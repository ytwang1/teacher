package com.netinnet.action;

import cn.netinnet.qdk.action.ActionClass;
import cn.netinnet.qdk.action.ActionClassResultDTO;
import cn.netinnet.qdk.util.RequestUtil;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class generateRandomInfo implements ActionClass {
    public ActionClassResultDTO execute(HttpServletRequest request) {

        //随机生成手机号码
        for (int i = 0; i < 11; i++) {//11代表循环11次，产生11个随机号码
            String randomPhoneNo = "13";//定义电话号码以13开头
            Random random = new Random();//定义random，产生随机数
            for (int j = 0; j < 9; j++) {
                //生成0~9 随机数
                randomPhoneNo += random.nextInt(9);
            }
            RequestUtil.addVar(request, "teacherRandomPhone", randomPhoneNo);
        }

        //随机生成名字
        for (int i=0;i< 20;i++){String[] name = {"Carol", "Ruth", "Sharon", "Michelle", "Laura", "Shirley", "Cynthia", "Angela", "Melissa", "Brenda","James", "John", "Robert", "Michael","Jose", "Larry", "Jeffrey", "Frank", "Scott"};
            int a = (int) Math.abs(name.length * Math.random());
            String randomName= name[a];
            RequestUtil.addVar(request, "teacherRandomName", randomName);
        }
        return new ActionClassResultDTO();
    }

}
