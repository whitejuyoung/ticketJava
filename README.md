Ticket Java
=============
온라인 티켓 예매 사이트

개발 배경 
-------------
>인터파크가 7일 발표한 ‘2018년 공연 시장 결산’ 자료에 따르면 작년 1월 1일부터 12월 28일까지 전체 공연 티켓 판매금액은 약 5441억원이었다. 
전년도 4411억원 대비 23% 증가한 수치다.<br>
출처 <https://www.edaily.co.kr/news/read?newsId=02712566622355424&mediaCodeNo=257><br>
 앞으로 온라인 티켓예매의 사용빈도가 더욱 증가할 것으로 판단되어 티켓예매사이트 1위인 **인터파크티켓** 을 벤치마킹하여 사이트를 제작하였다.<br>
 
 차별화 기능
-------------
>Ticket Java 는 기존사이트의 주요(예매) 기능과 **추천인 제도**, **티켓 선물** 기능을 추가하여 기존 사이트와 차별시켰다.<br>
**추천인 제도** 는 가입시에 추천인 아이디를 입력하면 현금처럼 사용 할 수 있는 포인트를 지급한다. 이 제도로 인해 사이트에 대한 홍보효과를 얻을 수 있다.<br>
**티켓 선물** 기능은 간편하게 사이트 내에서 선물 받을 사람의 아이디를 입력하여 티켓을 전달하는 기능이다.<br> 
평소에 인터파크 티켓 사이트를 사용하면서 이런 기능이 있었으면 좋겠다고 생각했던 기능을 추가했다.<br>

개발 환경
-------------
> OS : Window 7 <br>
Server: Tomcat 8.5 <br>
Language: Java. JSP, 
Javascript, SQL, HTML, CSS <br>
Tool : STS, Amazon RDS  <br>
Prototyping: kakao oven

구현 기능
-------------
#### SNS 계정 로그인(카카오api)
<img width="642" alt="m1" src="https://user-images.githubusercontent.com/52874887/62409165-5b5b0580-b60e-11e9-9b18-ff04f205fc1a.PNG">

~~~javascript
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('b0324449782ac528ee7c3b8a7689f174');
    function loginWithKakao() {
      // 로그인 창을 띄웁니다.
      Kakao.Auth.login({
        success: function(authObj) {
        	Kakao.API.request({
       	     url: '/v1/user/me',
       	     success: function(res) {
       	    	 console.log(res);
       	      var kakaoMemberId = res.id;      //유저의 카카오톡 고유 id
       	      var email = res.kaccount_email;   //유저의 이메일
       	      var name = res.properties.nickname; //유저가 등록한 별명
       	      console.log(kakaoMemberId);
       	      console.log(email);
       	      console.log(name);
              
   	    	      $.ajax({
   	    	    	 url:"${pageContext.request.contextPath}/member/memberLoginSNSforKakao.do",
   	    	    	 data: {kakaoMemberId:kakaoMemberId, email:email,name:name},
   	    	    	 dataType:"json",
   	    	    	 success:function(data){
   	    	    		 console.log(data);
   	    	    		 console.log(data.email);
   	    	    		 console.log(data.name);
                
   	    	    		 if(data.result === "0"){
   							$("#kakaoEnrollFrm input[name=kakaoMemberId]").val(kakaoMemberId);
   							$("#kakaoEnrollFrm input[name=name]").val(name);
   							$("#kakaoEnrollFrm input[name=email]").val(email);
   							$("#kakaoEnrollFrm").submit();
   	    	    		 }
   	    	    		 else{
   	    	    			 alert("아이디가 존재합니다. 해당아이디로 로그인합니다.");
   	    	    			 location.href="${pageContext.request.contextPath}/";
   	    	    		 }
   	    	    	 },
   	    	    	 error: function(jqxhr){
   	    	    		  console.log("ajax 처리 실패:"+jqxhr.status);
   	    	    	 }
   	    	      });
   		      
   	    	  },
       	     fail: function(error) {
       	      alert(JSON.stringify(error));
       	     }
       	    });
        },
        fail: function(err) {
          alert(JSON.stringify(err));
        }
      });
    };
~~~

~~~java
@RequestMapping("/memberLoginSNSforKakao.do")
	@ResponseBody
	public Map<String,String> memberLoginSNSforKakao(HttpServletRequest request,@RequestParam(value="kakaoMemberId", 
		    		   				required=false, defaultValue="") String kakaoMemberId,
										@RequestParam(value="email", required=false, defaultValue="") 
										String email, @RequestParam(value="name", required=false, defaultValue="") 
																										String name) {
		
		Member m = memberService.selectOneMemberByKakao(kakaoMemberId);
		logger.info("m"+m);
		logger.info("ka"+kakaoMemberId);
		Map<String,String> map = new HashMap<>(); 
		String result = "";
		map.put("kakaoMemberId",kakaoMemberId );
		map.put("email",email );
		map.put("name",name );
		logger.info(email);
		logger.info(name);

		if(m != null) {
			//회원 있음 
			map.put("result", "1");
			HttpSession session = request.getSession();
			session.setAttribute("memberLoggedIn", m);
			
		}
		else {
			//sns로 횐갑 안 했음...
			map.put("result", "0");
		}
			
		return map;
	}
	
	@RequestMapping("/memberEnrollKa.do")
	public ModelAndView memberEnrollKa(@RequestParam(value="kakaoMemberId", 
								required=false, defaultValue="") String kakaoMemberId,
							   @RequestParam(value="name", 
							    required=false, defaultValue="") String memberName,
							   @RequestParam(value="email", 
								required=false, defaultValue="") String email){
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("kakaoMemberId", kakaoMemberId);
		mav.addObject("memberName", memberName);
		mav.addObject("email", email);
		mav.setViewName("member/memberEnrollTJ");
		
		return mav;
	}
~~~

#### 예매자 성별/연령별 통계
<img width="443" alt="2019-08-07 13;29;24" src="https://user-images.githubusercontent.com/52874887/62594950-6d42ee00-b917-11e9-87c1-d9343e652788.PNG">

##### 성별 통계
~~~java
@RequestMapping("/viewGenderRate")
	@ResponseBody
	public Map<String,String> selectGenderRate(@RequestParam("performanceNo") String performanceNo) {
		
		//해당 공연 구매자 수 
		int totalPeople = performanceService.selectTotalPeople(performanceNo);
		
		int genderF = performanceService.selectGenderF(performanceNo);
	
		int genderM = performanceService.selectGenderM(performanceNo);
	
		//여자비율
		int rateF = (int)Math.round(((double)genderF / totalPeople)*100);

		//남자비율
		int rateM = (int)Math.round(((double)genderM / totalPeople)*100);

		Map<String,String> map = new HashMap<>();
		map.put("rateF", Integer.toString(rateF));
		map.put("rateM", Integer.toString(rateM));
		
		
		return map;
	}
~~~

##### 연령별 통계

~~~javascript
/*연령별 통계*/
		$.ajax({
			url:"${pageContext.request.contextPath}/performance/viewAgeRate",
			data:{performanceNo:"${performance.performanceNo }"},
			dataType: "json",
			success:function(data){
				/* console.log(data); */

				var teenager = data[0];
				var twenty = data[1];
				var thirty = data[2];
				var forty = data[3];
				var fiffty = data[4];
				var sixty = data[5];
				
				google.charts.load('current', {packages: ['corechart', 'bar']});
				
				google.charts.setOnLoadCallback(drawBasic);
				
				function drawBasic() {
					var data = new google.visualization.DataTable();
					
						data.addColumn('string');
						data.addColumn('number');
						data.addRows([
							
							['10대', teenager],
							['20대', twenty],
							['30대', thirty],
							['40대', forty],
							['50대', fiffty],
							['60대', sixty],
					
					]);
					var option = {
					          legend: 'none',
					          colors: ['rgb(224, 224, 224)']
					        };
					var chart = new google.visualization.ColumnChart(
									document.getElementById('chart_div'));
					
					chart.draw(data, option);
				}
		},
		error: function(jqxhr){
    		  console.log("ajax 처리 실패:"+jqxhr.status);
    	}
			
		});
		
	});
~~~

~~~java
@RequestMapping("/viewAgeRate")
	@ResponseBody
	public int[] selectAgeList(@RequestParam("performanceNo") String performanceNo){
		
		List<String> ageList = performanceService.selectAgeList(performanceNo);					
		logger.info("list"+ageList);
		//list[25, 1, 1]
		
		int teenager = 0;
		int twenty = 0;
		int thirty = 0;
		int forty = 0;
		int fiffty = 0;
		int sixty = 0;
		
		//리스트의 나이대 별로 분류해서 수 올리기 
		for(int i = 0 ;i<ageList.size();i++) {
			/*logger.info(ageList.get(i));*/
			//10대(1-10살도 10대로 포함)
			if(Integer.parseInt(ageList.get(i))<20)
				teenager ++;
			//20대
	           else if(Integer.parseInt(ageList.get(i)) >= 20 && Integer.parseInt(ageList.get(i))<30)
	               twenty++;
           //30대
           else if(Integer.parseInt(ageList.get(i)) >= 30 && Integer.parseInt(ageList.get(i))<40)
               thirty++;
           //40대
           else if(Integer.parseInt(ageList.get(i)) >= 40 && Integer.parseInt(ageList.get(i))<50)
               forty++;
           //50대
           else if(Integer.parseInt(ageList.get(i)) >= 50 &&Integer.parseInt(ageList.get(i))<60)
               fiffty++;
			//나머지는 60대로 간주 
			else
				sixty++;		
		}
		
		int[] ageArr = {teenager,twenty,thirty,forty,fiffty,sixty};

		return ageArr;
	}
~~~
#### 공연 날짜 보기
<img width="227" alt="m2" src="https://user-images.githubusercontent.com/52874887/62409357-dde4c480-b610-11e9-9615-acfb9b03f678.PNG">

~~~javascript
window.onload = function () {
	
	$.ajax({
		url:"${pageContext.request.contextPath}/performance/viewSchedule",
		data:{performanceNo:"${performance.performanceNo}"},
		dataType:"json",
		success:function(data){
			//console.log(data);	
			
			//오늘 날짜
			tYear = Number(tYear) ;
			tMonth = Number(tMonth);
			tDay = Number(tDay);
			
			for(var i = 0;i<data.length;i++){
				//console.log(data[i]);

				var year = data[i].substr(0,4);
				var month = data[i].substr(5,2);
				var day = data[i].substr(8,2);
				var m="";
				var d="";
				
				for(var j=1 ; j<10 ; j++){
					
					if(month === ('0'+j)){
						m = month.replace('0'+j,j);
					}
					if(day === ('0'+j)){
						d = day.replace('0'+j,j);
					}
				}
				if(m === "")
					m = month;
				if(d === "")
					d = day;
				
				//공연 날짜
				var nYear = Number(year);
				var nMonth = Number(month);
				var nDay = Number(day);
				
				//공연날짜가 지나지 않았을때만 표시
				if((nYear === tYear && nMonth === tMonth && nDay > tDay) ||
						(nYear === tYear && nMonth > tMonth)){
					//console.log("#"+year+"-"+m+"-"+d);
					//console.log($("#"+year+"-"+m+"-"+d));
					$("#"+year+"-"+m+"-"+d).css({"background":"#f39c12","color":"rgb(41, 41, 41)"});
				}
				
			}
			
		},
		error: function(jqxhr){
    		  console.log("ajax 처리 실패:"+jqxhr.status);
    		  console.log("ajax 처리 실패:"+jqxhr.textStatus);
    		  console.log("ajax 처리 실패:"+jqxhr.errorThrown);

    	}
	});
}
~~~

#### 날짜 클릭시 회차정보 보여주기
<img width="203" alt="m3" src="https://user-images.githubusercontent.com/52874887/62409358-dde4c480-b610-11e9-9e6c-327cadf99ca7.PNG">

~~~javascript
  $.ajax({
	    	  url:"${pageContext.request.contextPath}/performance/performanceRound",
	    	  data:{performanceNo:'${performance.performanceNo }', selectedDate:selectedDate},
	    	  dataType: "json",
	    	  success:function(data){

	    		  /*회차가 존재하지 않을경우*/
	    		  if(data.length == 0){
	    			  /* alert("없어욘"); */
	    			  var html = " <select id='selectionOf'>";
	    			  html += "<option selected='selected' disabled='disabled'>회차가 존재하지 않습니다</option>";
	    			  html += "</select>";
	    			  $("#choiceRround").html(html);
	    			  
	    			  var html2 = "<span id='beforeSelection'>관람일과 회차를 선택해 주세요.</span>";
	    			  
	    			  $("#possibleSeat").html(html2);
	    		  }
	    		  /*회차가 존재 할 경우*/
	    		  else{
	    			  var html = " <select id='selectionOf' name='selectRound'>";
		    			  html += "<option disabled='disabled' selected='selected'>회차를 선택해 주세요</option>";
	    			  for(var i=0;i<data.length;i++){
		    			  html += " <option class='round' id='"+(i+1)+"' value='"+data[i].PERFORMANCEROUND+"'>"+data[i].PERFORMANCEROUND.substring(11,16)+"</option>";	  
	    			  }
	    			 	 html += "</select>";
	    			  $("#choiceRround").html(html);	
	    			  
	    			  $("#selectionOf").change(function(){
	    					time = $(this).val();
	    					performanceNo = ${performance.performanceNo};
	    					availableSeat(time,performanceNo);
	    					
	    				}); 
	    			  
	    		  }	  
	    	  },
~~~
#### 회차 선택시 잔여좌석 보여주기
<img width="191" alt="m4" src="https://user-images.githubusercontent.com/52874887/62409359-dde4c480-b610-11e9-9ed5-d57cb9439d27.PNG">

~~~java
	@RequestMapping("/viewAvailableSeat")
	@ResponseBody
	public Map<String,String> selectAvailableSeat(@RequestParam("time") String time,
										@RequestParam("performanceNo") String performanceNo,
										@RequestParam("placeCode") String placeCode) {
		
		Map<String,String> paramMap2 = new HashMap<>();
		paramMap2.put("performanceNo", performanceNo);
		paramMap2.put("time", time);
		paramMap2.put("placeCode", placeCode);
		
		logger.info(paramMap2.toString());
		
		String scheduleNo = performanceService.selectscheduleNo(paramMap2);
		logger.info("scheduleNo="+scheduleNo);
		
		Map<String,String> paramMap3 = new HashMap<>();
		paramMap3.put("scheduleNo", scheduleNo);
		paramMap3.put("placeCode", placeCode);
		
		logger.info("placeCode"+placeCode);
		
		int soldSeat = performanceService.selectSoldSeat(paramMap3);

		logger.info("soldSeat"+soldSeat);
		
		int allSeat = performanceService.selectAllSeat(placeCode);
		
		String availableSeat = Integer.toString(allSeat - soldSeat);
		Map<String,String> resultMap = new HashMap<>();
		resultMap.put("availableSeat", availableSeat);
				
		return resultMap;
	}
~~~
전체 스토리보드
-------------
1. 메인 화면 <br>
<img width="630" alt="t1" src="https://user-images.githubusercontent.com/52874887/62406679-60a65900-b5ea-11e9-8658-608fe9f5b893.PNG">
<img width="630" alt="t111" src="https://user-images.githubusercontent.com/52874887/62406739-533d9e80-b5eb-11e9-962f-668d93ab1ad4.PNG">
2. 카테고리 클릭시 <br>
<img width="630" alt="t3" src="https://user-images.githubusercontent.com/52874887/62406681-60a65900-b5ea-11e9-8d83-db960129a478.PNG">
<img width="630" alt="t4" src="https://user-images.githubusercontent.com/52874887/62406682-613eef80-b5ea-11e9-88d4-6f6947789501.PNG">
3. 티켓 상세페이지 <br>
<img width="630" alt="t5" src="https://user-images.githubusercontent.com/52874887/62406667-5e43ff00-b5ea-11e9-8335-d4611513de64.PNG">
4. 공연 좌석 선택 페이지 <br>
<img width="630" alt="t16" src="https://user-images.githubusercontent.com/52874887/62406678-600dc280-b5ea-11e9-8dff-da31cb695fb0.PNG">
5. 회원가입 페이지 <br>
<img width="630" alt="t6" src="https://user-images.githubusercontent.com/52874887/62406668-5edc9580-b5ea-11e9-9b35-1ac16749b081.PNG">
<img width="630" alt="t7" src="https://user-images.githubusercontent.com/52874887/62406669-5edc9580-b5ea-11e9-938c-69469d926e17.PNG">
6. 구매내역 페이지 <br>
<img width="630" alt="t9" src="https://user-images.githubusercontent.com/52874887/62406671-5edc9580-b5ea-11e9-8e09-b62a472a085f.PNG">
7. 구매내역 상세보기 <br>
<img width="630" alt="t10" src="https://user-images.githubusercontent.com/52874887/62406672-5f752c00-b5ea-11e9-96a2-259e29e03f66.PNG">
8. 티켓 선물하기 <br>
<img width="630" alt="t11" src="https://user-images.githubusercontent.com/52874887/62406673-5f752c00-b5ea-11e9-94b7-48e9da9838be.PNG">
9. 마이페이지 <br> 
<img width="630" alt="t12" src="https://user-images.githubusercontent.com/52874887/62406674-5f752c00-b5ea-11e9-88dd-0e92f6d02204.PNG">
<img width="630" alt="t13" src="https://user-images.githubusercontent.com/52874887/62406675-600dc280-b5ea-11e9-8b65-f95f317b8066.PNG">
<img width="630" alt="t14" src="https://user-images.githubusercontent.com/52874887/62406676-600dc280-b5ea-11e9-8e2f-ab0abee565e9.PNG">
<img width="630" alt="t15" src="https://user-images.githubusercontent.com/52874887/62406677-600dc280-b5ea-11e9-94e0-0a6c78cfc90f.PNG">



