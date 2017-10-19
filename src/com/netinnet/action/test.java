package com.netinnet.action;

import cn.netinnet.qdk.action.ActionClass;
import cn.netinnet.qdk.action.ActionClassResultDTO;
import cn.netinnet.qdk.util.RequestUtil;

import javax.servlet.http.HttpServletRequest;

public class test implements ActionClass {
    public ActionClassResultDTO execute(HttpServletRequest request) {
        System.out.print("###################");
        /*

         */
        String randomPhoneNo="9999999999";
        /*

         */
        RequestUtil.addVar(request, "teacherPhone222", randomPhoneNo);
        return new ActionClassResultDTO();
    }
}
