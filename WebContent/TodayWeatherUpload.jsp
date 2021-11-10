<%@page import="dao.GradeDAO"%>
<%@page import="dto.TodayWeatherDTO"%>
<%@page import="dao.TodayWeatherDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! // '실제 파일을 업로드하는 함수'의 선언부

public String processUploadFile(FileItem fileItem, String newFileName, String dir)  // FileItem - commons.fileupload 껄로 추가해줘라 
		throws IOException{ 									// dir- Directory
	String f = fileItem.getName();
	long sizeInBytes = fileItem.getSize();
		
	String FileName = "";
	String fpost = "";
	
	// upload file이 정상일 경우 = 파일사이즈가 0보다 큰 경우
	if(sizeInBytes > 0){
		// d:\\tmpfolder\\abc.txt 또는 d:/tmpfolder/abc.txt -> 실제올라가는 파일 명이 abc.txt 
		// 올리고자 하는 파일의 경로와 파일의 이름을 분리해야한다. \\ 든 / 든 파일의 경로가 길거나짧거나 상관없이 분리가능해야함
		int idx = f.lastIndexOf("\\");
		if(idx == -1){ // "\\"를 못찾았다면 /로 찾아줘야 한다.
			idx = f.lastIndexOf("/");	
		}
		// fileName = f.substring(beginIndex, endIndex); beginIndex = idx 다음값부터 끝까지가 파일명
		FileName = f.substring(idx+1);
		
		// 파일을 업로드 한다는 것은 파일을 새로 만들어서 업로드파일의 데이터를 복사해서 넣는 격(byte로써)
		// 이 구문이 실제로 파일을 업로드하는 코드 부분
		try{
			File uploadFile = new File(dir, newFileName);
			fileItem.write(uploadFile); // 실제 파일 업로드 코드, 원래는 클로즈 해줘야하나 그냥 둬도 된다.
		}catch(Exception e){
			e.printStackTrace();
		};
	}
	return FileName; // 스트링갑이 의미가없는데 그냥 붙임
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일업로드jsp</title>
</head>
<body>

<!-- 업로드 실행 함수가 실행되는 부분 -->
<%
/* 	한글 파일의 경우 깨지는 경우가 많음(파일명 손실)
	내파일.jpg면 -> 원래 올릴 때는 시간을 파일명으로 만들어서 변환하는 경우가 많음
	실제 파일명을 시간파일명(변환파일명)과 같이 올린다. 다운로드를 받게 돠면 변환파일명 다운로드 완료 후 실제 파일명으로 바꿔줌
	db에 올라갈 때, 실제파일명: 내파일.jpg / 변환파일명: 21062415060000.jpg
	
	* 톰캣 배포 - 톰캣을 계속 껐다 켰다가 하면 파일이 날라가기도 함
	* 지정 폴더에 저장하면 파일이 날라가지는 않음
*/

// 톰캣 배포
String fupload = application.getRealPath("/upload"); // WebContent에 저장공간을 만듦
// 지정 폴더 저장: String fupload = "c:\\";


System.out.println("파일업로드: " + fupload);
String yourTempDir = fupload;
int yourMaxRequestSize = 500*1024*1024; // = 5mb
int yourMaxMemorySize = 100*1024; // = 1kb



// [db에 들어갈 데이터들 정리]
		
// form field 데이터
String UserID="";
//String UserName="";
String Title="";
String Content="";
String LocationCode="";

// file data
String FileName="";
String newFileName = "";

boolean isMultipart = ServletFileUpload.isMultipartContent(request); // tomcat x, 그냥 commons
if(isMultipart == true){
	// 위에서 넘겨준 fileItem 의 Object를 생성하는 클래스
	
	DiskFileItemFactory factory = new DiskFileItemFactory(); // 파일을 서버에 새로 만들어주는 파일공장 factory 생성, 	commons
	
	factory.setSizeThreshold(yourMaxMemorySize); // 새로만드는 파일의 사이즈설정
	factory.setRepository(new File(yourTempDir)); // 새 파일의 디렉토리 설정
	ServletFileUpload upload = new ServletFileUpload(factory); //팩토리 세팅해준 것을 싹 다 서블렛(서버)에 넣어준다.
	upload.setSizeMax(yourMaxRequestSize);
	// 여태까지가 파일 업로드를 하기위한 설정임
	
	
	// 새로 생성한 파일에 원본 업로드 파일의 데이터들을 복사하기 위한(담기위한) 설정 시작
	List<FileItem> items = upload.parseRequest(request); // FileItem 이라는 형식에 대한 새로운 리스트를 생성, 파싱을 통해서 파일업로드를 뭉텅이로 업로드하는 요청이 넘어옴
	Iterator<FileItem> iter = items.iterator(); // 폼필드데이터와 파일데이터가 분리되서 넘어오는 것이 아니라 아이템즈에 담아서 한번에 묶여서 넘어옴, 이터레이터를 통해서 하나씩 꺼낸다.
	
	// 이터레이터를 통해 하나씩 꺼내는 데이터를 처리
	while(iter.hasNext()){
		FileItem item = iter.next();
		
		if(item.isFormField()){ // java 에 내장된 기본 패키지 fileupload에 속한 기본 클래스 FileItem에 내장된 기본 메소드 isFormField
								
			if(item.getFieldName().equals("UserID")){
				UserID = item.getString("UTF-8");
			}else if(item.getFieldName().equals("Title")){
				Title = item.getString("UTF-8");
			}else if(item.getFieldName().equals("Content")){
				Content = item.getString("UTF-8");
			}else if(item.getFieldName().equals("LocationCode")){
				LocationCode = item.getString("UTF-8");
			}
				
			// formfield 데이터가 아니라 파일데이터쪽이면 false
		}else{
			if(item.getFieldName().equals("fileload")){ // 업로드 대상 파일은 item, 저장된 공간 디렉토리는 fupload // 파일을 byte로 변환하는 과정은 어디??
				// 확장자명
				String fileName = item.getName();	// 1.abc.txt
				int lastInNum = fileName.lastIndexOf(".");
				String exName = fileName.substring(lastInNum);
				
				// 새로운 파일명
				newFileName = (new Date().getTime()) + "";		
				newFileName = newFileName + exName;					
				FileName = processUploadFile(item, newFileName, fupload);
			}
		}
			
		// if(item.isFormField()) 문 종료
		
	}	// while문 종료
	System.out.println("파일 변환하여 업로드 성공");
} else{
	System.out.println("Multipart가 아님");	// 파일의 폼필드와 데이터 정보가 제대로 갖춰지지 않았다는 소리
} //if(isMultipart == true)~else문 종료
// 콘솔 창에 파일업로드 경로가 나온다면 성공

// db에 데이터 저장 : 여기서부터 에러가 나고 있다...!!
TodayWeatherDAO dao = TodayWeatherDAO.getInstance();
boolean isS = dao.addTodayWeather(
				new TodayWeatherDTO(UserID,/* UserName,*/ Title, Content, FileName, newFileName, LocationCode));
if(isS){

	GradeDAO gdao = GradeDAO.getInstance();
	gdao.updatePoint(UserID);
	gdao.setGradeCode(UserID);
	%>
	<script type="text/javascript">
	alert('파일 업로드 성공!');
	location.href = "Main.jsp?content=TodayWeatherList";
	</script>	
	<%
}else{
	%>
	<script type="text/javascript">
	alert('파일 업로드 실패');
	location.href = "Main.jsp?content=TodayWeatherList";
	</script>	
	<%
}
%>

</body>
</html>