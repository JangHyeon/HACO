<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div id="calendarView">

</div>
</body>
</html>
<script type="text/javascript">
 
    var nowDate = new Date();               //���� ��¥ ��ü ����  
    var nYear = nowDate.getFullYear();      //������ �⵵  
    var nMonth = nowDate.getMonth() ;       //������ �� �� 0������ ����  
    var nDate = nowDate.getDate();           //������ ��  
    var nNumday = nowDate.getDay();         //������ ���� 0=�Ͽ���...6=�����  
    var endDay=new Array(31,28,31,30,31,30,31,31,30,31,30,31);      //������ ������ ��¥  
    var dayName=new Array("��", "��", "ȭ", "��", "��", "��", "��"); // ���� ������ ���� ���� �ٲ� �Լ�  
    var col=0;  //������ �̿��ؼ� ���߿� �յ� �� ��¥ĭ ���   
    eDate= new Date(nYear,nMonth,1);       // 1���� ���� ������ ���ϱ� ���ؼ���¥ ��ü ����  
    var fNumday=eDate.getDay();    // �̹��� 1���� ���� ����  
    var lastDay=endDay[nMonth]; //�̹����� ������ ��¥  
  
    function calendar(){  
  
        if ((eDate.getMonth()==1)&&(((eDate.getYear()%4==0)&&(eDate.getYear() %100 !=0))||eDate.getYear() % 400 ==0 ))  
        {lastDay=29;} // 0�� ���� �����ϹǷ� 1�� 2����. ���� ��� 4�⸶�� 29�� , 100��� 28��, 400�� °�� 29��  
  
        calendarStr  = "<TABLE>"  
        calendarStr +="<TR align=center><TD valign=middle>"  
  
        calendarStr +="</TD><TD colspan=5 >"  
        calendarStr +="<font size=3 color=black>  <b>"+eDate.getFullYear()+"�� "+(eDate.getMonth()+1)+"��</b></font> "// �ش��ϴ� �⵵�� �� ǥ��  
        calendarStr +="</TD><TD valign=middle>"  
  
        calendarStr +="</TD></TR><TR>"  
        for (i=0;i<dayName.length;i++){            
            calendarStr +="<TD class=week>"+dayName[i] + "</TD>" // ���� ������ ��¥ ���Ϸ� �Է�  
        }  
  
        calendarStr +="</TR><TR align=center>"  
  
        for (i=0;i<fNumday;i++){          // ù��° ��¥�� ���� ������ ���ؼ� ���������� ��ĭ ó��  
            calendarStr +="<TD>&nbsp;</TD>"   
            col++;                       
        }  
  
        for ( i=1; i<=lastDay; i++){       // �ش� ���� �޷�   
            if(eDate.getFullYear()==nYear&&eDate.getMonth()==nMonth&&i==nDate){//�����̸� today ��Ÿ�Ϸ� ǥ��  
                calendarStr +="<TD class=today >"+i+"</TD>"   
            }else{  
                if(col==0){              //�Ͽ����̸�  
                    calendarStr +="<TD class=sunday>"+i+"</TD>"  
                }else if(1<=col&&col<=5){//�׿� ����� ���̸�  
                    calendarStr +="<TD class=workday>"+i+"</TD>"   
                }else if(col==6){        //������̸�  
                    calendarStr +="<TD class=satday>"+i+"</TD>"   
                }  
            }             
  
            col++;  
  
            if(col==7){     //7ĭ�� ����� �� �ٲپ� �� ���� ����� �ٽ� ù ĭ���� ����  
                calendarStr +="</TR><TR align=center>"  
                col=0;  
            }  
        }     
  
        for (i=col;i<dayName.length;i++){        //������ ������ ���� ������ �� ĭ �����  
            calendarStr +="<TD>&nbsp;</TD>"  
        }  
  
        calendarStr +="</TR></TABLE>"  
        document.getElementById('calendarView').innerHTML = calendarStr //���� �޷� �ҽ��� ȭ�鿡 �����ֱ�  
    }  
    
</script>