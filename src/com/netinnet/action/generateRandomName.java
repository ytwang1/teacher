package com.netinnet.action;

import cn.netinnet.qdk.action.ActionClass;
import cn.netinnet.qdk.action.ActionClassResultDTO;
import cn.netinnet.qdk.util.RequestUtil;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class generateRandomName implements ActionClass {
    public ActionClassResultDTO execute(HttpServletRequest request) {

        for (int i=0;i< 10;i++){String[] name = {"Carol", "Ruth", "Sharon", "Michelle", "Laura", "James", "John", "Robert", "Michael"};
            int a = (int) Math.abs(name.length * Math.random());
            String randomName= name[a];
            RequestUtil.addVar(request, "teacherRandomName", randomName);
        }
        return new ActionClassResultDTO();
    }

}
