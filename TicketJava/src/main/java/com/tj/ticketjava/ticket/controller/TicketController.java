package com.tj.ticketjava.ticket.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.tj.ticketjava.member.model.service.MailService;
import com.tj.ticketjava.member.model.service.MemberService;
import com.tj.ticketjava.member.model.vo.Member;
import com.tj.ticketjava.member.model.vo.Point;
import com.tj.ticketjava.performance.model.service.PerformanceService;
import com.tj.ticketjava.performance.model.vo.Performance;
import com.tj.ticketjava.ticket.model.service.TicketService;
import com.tj.ticketjava.ticket.model.vo.Purchase;
import com.tj.ticketjava.ticket.model.vo.Seat;
@Controller
@SessionAttributes(value="memberLoggedIn")
public class TicketController {
    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    TicketService ticketService;
    @Autowired
    PerformanceService performanceService;
    @Autowired
    MemberService memberService;
    @Autowired
    private MailService mailService;
    
    //창띄우기
    @RequestMapping("/ticket/seat.do")
    public String checkSeat(Seat seat, Model model,@RequestParam("performanceNo") int performanceNo) {
    
        Performance performance = performanceService.selectTicket(performanceNo);
        logger.info("performance(Seat)="+performance);
        model.addAttribute("performance",performance);
                
        return "ticket/seat";
    }
    
    //ing로 바꾸기
    @ResponseBody
    @PostMapping("/ticket/insertTicket.do")
    public Map<Object, Object> insertTicket(@RequestBody Seat seat){
        Map<Object, Object> map = new HashMap<>();
        logger.info("seat={}",seat.getSeatList());
       int check = 0;
       try {
           check = ticketService.checkTicket(seat.getSeatList());
        
        } catch (Exception e) {
            
            String msg = "이미 예약된 좌석입니다.";
            map.put("msg", msg);
            check = 1;
            
        }
           
       if(check < 1) {
            List<Seat> sList= ticketService.insertTicket(seat.getSeatList());
            String msg = "예약성공!";
            map.put("msg", msg);
            map.put("sList", sList);
            
            
            
        }
        
        return map;
    
    }
    
    //화면 떳을때 예매된 좌석 표시
    @ResponseBody
    @RequestMapping("/ticket/checkSeat.do")
    public List<Seat> checkSeat(@RequestParam("performanceNo") String performanceNo,
                                            @RequestParam("time") String time){
        
        Map<String,String> paramMap = new HashMap<>();
        paramMap.put("performanceNo", performanceNo);
        paramMap.put("time", time);
        
        logger.info("performanceNo@@="+performanceNo);
        logger.info("time@@="+time);
        
        List<Seat> status = ticketService.checkSeat(paramMap);
        
        for(int k = 0 ;k<status.size();k++) {
            status.get(k).setTime(time);
        }
        
        
        logger.info("status="+status);
        
        
        return status;
    }
    
    //결제창으로 넘어가기
    @RequestMapping(value="/ticket/payTicket.do", method = {RequestMethod.GET, RequestMethod.POST})
    public void payTicket(@RequestParam (value="passKey") List<Integer> seatKeyArr ,@RequestParam("performanceNo") int performanceNo, 
            @RequestParam(value="selectedDate") String selectedDate, @RequestParam int scheduleNo, Model model) {
        Performance performance = performanceService.selectTicket(performanceNo);
        model.addAttribute("performance",performance);
        
        ArrayList seatNum = new ArrayList();
        
        for(int i = 0; i<seatKeyArr.size() ;i++) {
            
            if(seatKeyArr.get(i) != 0) {
                seatNum.add(seatKeyArr.get(i));
            }
            
        }
        model.addAttribute("seatNum",seatNum);
        model.addAttribute("selectedDate", selectedDate);
        model.addAttribute("scheduleNo", scheduleNo);
    }
    
    
    @ResponseBody
    @PostMapping(value="/ticket/ticketInfo")
    public List<Map<String, String>> ticketInfo(@RequestParam (value="seatNumArr[]") List<Integer> seatNumArr) {
        ArrayList seatNum = new ArrayList();
        for(int i = 0; i<seatNumArr.size() ;i++) {
                    
            if(seatNumArr.get(i) != 0) {
                seatNum.add(seatNumArr.get(i));
            }
            
        }
        List<Map<String, String>> listMap = new ArrayList<Map<String,String>>();
        
        for(int i=0; i<seatNum.size(); i++) {
            Map<String,Integer> result = new HashMap<String, Integer>();
            Map<String, String> resultString = new HashMap<>();
            result = ticketService.ticketInfo((Integer)seatNum.get(i));
            resultString.put("SEAT_NO", String.valueOf(result.get("SEAT_NO")));
            resultString.put("SEAT_ROW", String.valueOf(result.get("SEAT_ROW")));
            resultString.put("SCHEDULE_NO", String.valueOf(result.get("SCHEDULE_NO")));
            resultString.put("PERFORMANCE_NO", String.valueOf(result.get("PERFORMANCE_NO")));
            resultString.put("PLACE_CODE", String.valueOf(result.get("PLACE_CODE")));
            resultString.put("SEAT_STATUS", String.valueOf(result.get("SEAT_STATUS")));
            listMap.add(resultString);
        }
        
        return listMap;
        
        
    }
    
    @PostMapping("/ticket/addTicket")
    public String addTicket(Model model, Purchase purchase, @RequestParam(value="seatInfo2") List<Integer> seatKeyArr, 
            @RequestParam(value="seatR") List<Integer>seatR, @RequestParam(value="seatN") List<Integer>seatN, @RequestParam int performanceNo,
            @RequestParam String performanceTitle, @RequestParam String performanceCode ,@RequestParam String placeCode,
            @RequestParam int scheduleNo, @RequestParam String memberId, @RequestParam(value="totalPrice") int price,
            @RequestParam String scheduleDate, @RequestParam(value="performancePlace") String placeName,
            @RequestParam String memberName, @RequestParam String paymentStatus, @RequestParam String ticketWay,
            @RequestParam(value="address", required=false, defaultValue="") String address,
            @RequestParam int ticketOnePrice
             ){
        
        logger.info("purchase="+purchase);
        purchase.setTotalPrice(price);
        System.out.println(purchase);
        
        int result = ticketService.addPurchase(purchase);
        
        Member m =memberService.selectOneMember(memberId);
        
        if(purchase.getUsePoint()>0) {
            int point = m.getPoint() - purchase.getUsePoint();
            m.setPoint(point);
            memberService.updatePoint(m);
            Point ap = new Point();
            ap.setMemberId(memberId);
            ap.setPoint(purchase.getUsePoint());
            ap.setPointMessage("티켓 구매");
            ap.setPointStatus("사용");
            memberService.insertAccumulatePoint(ap);
        }
        
        
        int result2 = 0;
        //null, 0배열에서제거
        ArrayList seatNNum = new ArrayList();
        ArrayList seatRNum = new ArrayList();
        ArrayList seatNum = new ArrayList();
        System.out.println(seatKeyArr+"==================================");
        for(int i = 0; i<seatKeyArr.size() ;i++) {
                    
            if(seatKeyArr.get(i) != 0) {
                seatNum.add(seatKeyArr.get(i));
            }
        }
        logger.info("seatNum="+seatNum);      
    
        for(int i=0; i<seatNum.size(); i++) {
            result2 = ticketService.updateStatus((Integer)seatNum.get(i));
        }
        
        for(int i = 0; i<seatN.size() ;i++) {
                    
            if(seatN.get(i) != 0) {
                seatNNum.add(seatN.get(i));
            }
            if(seatR.get(i) != 0) {
                seatRNum.add(seatR.get(i));
            }
            
        }
        
        //Ticket Insert!        
        List<Map<Object,Object>> listMap = new ArrayList<Map<Object,Object>>();
        int result3 = 0;
        price = price/seatRNum.size()-(1000*seatNNum.size());
        for(int i=0; i<seatRNum.size(); i++) {
            Map<Object,Object> map1 = new HashMap<Object, Object>();
            map1.put("placeCode",placeCode);
            map1.put("scheduleNo",scheduleNo);
            map1.put("performanceNo",performanceNo);
            map1.put("memberId",memberId);
            map1.put("ticketOnePrice",ticketOnePrice);
            map1.put("performanceTitle",performanceTitle);
            map1.put("scheduleDate",scheduleDate);
            map1.put("placeName",placeName);
            map1.put("memberName",memberName);
            map1.put("performanceCode",performanceCode);
            map1.put("paymentStatus",paymentStatus);
            map1.put("ticketWay",ticketWay);
            map1.put("seatRow",seatRNum.get(i));
            map1.put("seatNo",seatNNum.get(i));
            map1.put("address",address);  
            logger.info("map1="+map1);
            result3 = ticketService.addTicket(map1);
            
            
        }
        
        if("X".equals(paymentStatus)) {
            //계좌번호 이메일 발송
            String subject = "TICKET JAVA 계좌번호 안내드립니다.";
            StringBuilder sb = new StringBuilder();
            sb.append(m.getMemberName()+"님, TICKET JAVA입니다.")
              .append(System.getProperty("line.separator"))
              .append("계좌번호로 24시간 이내에 입금해주세요.")
              .append(System.getProperty("line.separator"))
              .append("계좌번호 : 국민은행) 111-2222-3333  예금주 : 티켓자바")
              .append(System.getProperty("line.separator"))
              .append("감사합니다.");
            mailService.send(subject, sb.toString(), "finalticketjava@gmail.com", m.getEmail(), null);
            
        }
        
        String loc = result>0 && result2>0 && result3>0?"/":"/";
        String msg = result>0 && result2>0 && result3>0?"예매완료!":"예매실패!";
        
        m =memberService.selectOneMember(memberId);
        
        model.addAttribute("loc", loc);
        model.addAttribute("msg", msg);
        model.addAttribute("memberLoggedIn", m);
        
        return "common/msg";
        
        
    }
    
    @ResponseBody
    @RequestMapping("/ticket/esunjoa")
    public int esunjoa(@RequestParam String row, @RequestParam String no,@RequestParam String scheduleNo, @RequestParam String performanceNo) {
        Map<Object,Object> map = new HashMap<Object, Object>();
        
        map.put("row",row);
        map.put("no",no);
        map.put("scheduleNo",scheduleNo);
        map.put("performanceNo",performanceNo);
        
        System.out.println(map);
    
        int result = ticketService.esunjoa(map);
        System.out.println(result+"zz");
        return result;
    }
    @PostMapping("/ticket/backTicket")
    public String backTicket(@RequestParam (value="passKey") List<Integer> seatKeyArr,Model model) {
        System.out.println(seatKeyArr);
        ArrayList seatNum = new ArrayList();
        for(int i = 0; i<seatKeyArr.size() ;i++) {
                    
            if(seatKeyArr.get(i) != 0) {
                seatNum.add(seatKeyArr.get(i));
            }
            
        }
        
        for(int i=0; i<seatNum.size(); i++) {
            int result = ticketService.deleteIng((Integer)seatNum.get(i));
        }
        String loc = "/";
        String msg = "선택했던 좌석이 취소되었습니다.";
        model.addAttribute("loc", loc);
        model.addAttribute("msg", msg);
        
        return "common/msg";
    }
    
    
}