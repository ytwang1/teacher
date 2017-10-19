package com.netinnet.action;

import cn.netinnet.qdk.action.ActionClass;
import cn.netinnet.qdk.action.ActionClassResultDTO;
import cn.netinnet.qdk.util.RequestUtil;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class generateRandomName implements ActionClass {
    public ActionClassResultDTO execute(HttpServletRequest request) {
        return new ActionClassResultDTO();
    }

}
