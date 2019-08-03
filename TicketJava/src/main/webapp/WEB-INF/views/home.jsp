<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/home.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>

$(function(){
	
	
	$.ajax({
		url: "${pageContext.request.contextPath}/performance/rankList.do",
		success: function(data){
 				var html = "";
 				html += "<tr><td colspan='4' class='title-td'><hr class='decoline'/>|<span class='rank-title'>M U S I C A L</span>|<hr class='decoline'/></td></tr>";
 				html += "<tr>";
				for(var i in data){
					if(parseInt(i)<4){
						html += "<td class='ranking'>";
						if(parseInt(i)==0)
							html += "<img class='ranking-no-img' src='${pageContext.request.contextPath }/resources/images/main/bookmark_red.png'/>";
						else
							html += "<img class='ranking-no-img' src='${pageContext.request.contextPath }/resources/images/main/bookmark_gray.png'/>";										
						html += "<span class='ranking-no'>"+(parseInt(i)+1)+"</span>";
						html += "<img onclick='img_click("+data[i].performanceNo+");' class='poster' src='${pageContext.request.contextPath }/resources/upload/performance/"+data[i].renamedFileName+"'/>";
						html += "</td>";
					}
				}
				html += "</tr>";

					
				$("#musical-table").html(html);
		},
		error: function(jqxhr){
			console.log("ajax처리실패:"+jqxhr.status);
		}
	}); 
	
	$.ajax({
		url: "${pageContext.request.contextPath}/performance/rankListConcert.do",
		success: function(data){
 				var html = "";
 				html += "<tr>";
 				html += "<td colspan='4' class='title-td'><hr class='decoline'/>|<span class='rank-title'>C O N C E R T</span>|<hr class='decoline'/></td>";
 				html += "</tr>"
 				html += "<tr>";
				for(var i in data){
					if(parseInt(i)<4){
						html += "<td class='ranking'>";
						if(parseInt(i)==0)
							html += "<img class='ranking-no-img' src='${pageContext.request.contextPath }/resources/images/main/bookmark_red.png'/>";
						else
							html += "<img class='ranking-no-img' src='${pageContext.request.contextPath }/resources/images/main/bookmark_gray.png'/>";										
						html += "<span class='ranking-no'>"+(parseInt(i)+1)+"</span>";
						html += "<img onclick='img_click("+data[i].performanceNo+");' class='poster' src='${pageContext.request.contextPath }/resources/upload/performance/"+data[i].renamedFileName+"'/>";
						html += "</td>";
					}
				}
				html += "</tr>";

					
				$("#concert-table").html(html);
		},
		error: function(jqxhr){
			console.log("ajax처리실패:"+jqxhr.status);
		}
	}); 
	
	$.ajax({
		url: "${pageContext.request.contextPath}/performance/rankListPlay.do",
		success: function(data){
 				var html = "";
 				html += "<tr><td colspan='4' class='title-td'><hr class='decoline'/>|<span class='rank-title'>P L A Y</span>|<hr class='decoline'/></td></tr>";
 				for(var i in data){
					if(parseInt(i)<4){
						html += "<td class='ranking'>";
						if(parseInt(i)==0)
							html += "<img class='ranking-no-img' src='${pageContext.request.contextPath }/resources/images/main/bookmark_red.png'/>";
						else
							html += "<img class='ranking-no-img' src='${pageContext.request.contextPath }/resources/images/main/bookmark_gray.png'/>";										
						html += "<span class='ranking-no'>"+(parseInt(i)+1)+"</span>";
						html += "<img onclick='img_click("+data[i].performanceNo+");' class='poster' src='${pageContext.request.contextPath }/resources/upload/performance/"+data[i].renamedFileName+"'/>";
						html += "</td>";
					}
				}
				html += "</tr>";
				$("#play-table").html(html);
		},
		error: function(jqxhr){
			console.log("ajax처리실패:"+jqxhr.status);
		}
	});
	
	/* 메인이미지 슬라이드 */
 	$.ajax({
		url: "${pageContext.request.contextPath}/performance/mainImageCnt.do",
		success: function(data){
 			var i = 0;
 			img_slide(i);
 			
 			i = 1;
 		 	var interval = setInterval(function(){
 		 		 if(i>=data){
 		 			i=0;
 		 		}
 		 		img_slide(i);
 		 		i++;
 		 	},5000);
 		 	
 		 	$('#main-img-container').hover(function(){
 		 		clearInterval(interval);
 		 	},function(){
 		 		interval = setInterval(function(){
 	 		 		 if(i>=data){
 	 		 			i=0;
 	 		 		}
 	 		 		img_slide(i);
 	 		 		i++;
 	 		 	},5000);
 		 	});

		},
		error: function(jqxhr){
			console.log("ajax처리실패:"+jqxhr.status);
		}
		 
	});
});


/* 메인이미지 가져오기 */
   function img_slide(i){
	 $.ajax({
		    url : "${pageContext.request.contextPath}/performance/mainImage.do",
		    success : function(data) {
			  		html = "<img onclick='img_click("+data[i].performanceNo+");' class='main-img' src='${pageContext.request.contextPath }/resources/upload/performance/"+data[i].renamedFileName+"'/>";
					$("#main-img-container").hide().html(html).fadeIn(500);
		    },
		    error: function(jqxhr){
				console.log("ajax처리실패:"+jqxhr.status);
			}
	});	
	 
	
}

/* 이미지 클릭시 상세페이지로 이동 */
function img_click(performanceNo){
	location.href="${pageContext.request.contextPath }/performance/performanceView?performanceNo="+performanceNo;
}


</script>
<div id="main-img-container">
</div>

<table class="main-table" id="musical-table"></table>
<table class="main-table" id="concert-table"></table>
<table class="main-table" id="play-table"></table>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>