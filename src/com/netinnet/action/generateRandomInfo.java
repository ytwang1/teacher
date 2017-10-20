package com.netinnet.action;

import cn.netinnet.qdk.action.ActionClass;
import cn.netinnet.qdk.action.ActionClassResultDTO;
import cn.netinnet.qdk.util.RequestUtil;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class generateRandomInfo implements ActionClass {
    public ActionClassResultDTO execute(HttpServletRequest request) {

        //��������ֻ�����
        for (int i = 0; i < 11; i++) {//11����ѭ��11�Σ�����11���������
            String randomPhoneNo = "13";//����绰������13��ͷ
            Random random = new Random();//����random�����������
            for (int j = 0; j < 9; j++) {
                //����0~9 �����
                randomPhoneNo += random.nextInt(9);
            }
            RequestUtil.addVar(request, "teacherRandomPhone", randomPhoneNo);
        }

        //����������ֺ�����
        for (int i=0;i< 20;i++){
            String[] name = {"Carol", "Ruth", "Sharon", "Michelle", "Laura", "Shirley", "Cynthia", "Angela", "Melissa", "Brenda","James", "John", "Robert", "Michael","Jose", "Larry", "Jeffrey", "Frank", "Scott"};
            String[] email = {"@gmail.com", "@qq.com", "@126.com", "@163.com","@sina.com", "@live.com","@yahoo.com,@msn.com", "@hotmail.com", "@sohu.com"};
            int a = (int) Math.abs(name.length * Math.random());
            int b = (int) Math.abs(email.length * Math.random());
            String randomName= name[a];
            String randomEmail=name[a]+email[b];
            RequestUtil.addVar(request, "teacherRandomName", randomName);
            RequestUtil.addVar(request, "teacherRandomEmail", randomEmail);
        }
        return new ActionClassResultDTO();
    }

}
