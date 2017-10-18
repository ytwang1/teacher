package com.netinnet.action;

import javax.servlet.http.HttpServletRequest;

import cn.netinnet.qdk.action.ActionClass;
import cn.netinnet.qdk.action.ActionClassResultDTO;
import cn.netinnet.qdk.util.RequestUtil;

import com.netinnet.extern.util.DoServiceUtil;

/**
 * µ÷ÓÃservice
 * */
public class InvokeServiceAction implements ActionClass {

	public ActionClassResultDTO execute(HttpServletRequest request) {
		String strReturnData = DoServiceUtil.doService("self?action=serviceTest&start=randomBlog");
		RequestUtil.addVar(request, "returnData", strReturnData);
		return new ActionClassResultDTO();
	}

}
