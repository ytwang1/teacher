package com.netinnet.action;

import cn.netinnet.qdk.action.ActionClass;
import cn.netinnet.qdk.action.ActionClassResultDTO;
import cn.netinnet.qdk.util.RequestUtil;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class generateRandomInfo implements ActionClass {
    public ActionClassResultDTO execute(HttpServletRequest request) {

        for (int i = 0; i < 11; i++) {//11代表循环11次，产生11个随机号码
            String randomPhoneNo = "13";//定义电话号码以13开头
            Random random = new Random();//定义random，产生随机数
            for (int j = 0; j < 9; j++) {
                //生成0~9 随机数
                randomPhoneNo += random.nextInt(9);
            }
            RequestUtil.addVar(request, "teacherRandomPhone", randomPhoneNo);
        }

        for (int i=0;i< 10;i++){String[] name = {"Carol", "Ruth", "Sharon", "Michelle", "Laura", "James", "John", "Robert", "Michael"};
            int a = (int) Math.abs(name.length * Math.random());
            String randomName= name[a];
            RequestUtil.addVar(request, "teacherRandomName", randomName);
        }
        return new ActionClassResultDTO();
    }

}
