package com.netinnet.action;

import cn.netinnet.qdk.action.ActionClass;
import cn.netinnet.qdk.action.ActionClassResultDTO;
import cn.netinnet.qdk.util.RequestUtil;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class generateRandomPhone implements ActionClass {
    public ActionClassResultDTO execute(HttpServletRequest request) {
        System.out.print("###################");
        /*

         */
        for (int i = 0; i < 11; i++) {//11����ѭ��11�Σ�����11���������
            String randomPhoneNo = "13";//����绰������13��ͷ
            Random random = new Random();//����random�����������
            for (int j = 0; j < 9; j++) {
                //����0~9 �����
                randomPhoneNo += random.nextInt(9);
            }
            RequestUtil.addVar(request, "teacherRandomPhone", randomPhoneNo);
        }
        /*

         */

        return new ActionClassResultDTO();
    }
}
