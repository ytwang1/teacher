package com.netinnet.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;

import cn.netinnet.qdk.action.ActionClass;
import cn.netinnet.qdk.action.ActionClassResultDTO;
import cn.netinnet.qdk.util.RequestUtil;

import com.alibaba.fastjson.JSONObject;

/**
 * �����ϴ��ļ�֮����е��߼�����
 * */
public class AfterReceiveUploadFileAction implements ActionClass
{

	public ActionClassResultDTO execute(HttpServletRequest request) {
		// ������������ cn.netinnet.qdk.action.doUploadDataFile ִ�����ϴ�����֮�󴫵ݹ����Ĳ���
		// ��ʾ�ļ��ϴ������0 - �ϴ��ļ�ʧ��
		String uploadFileResultCode = RequestUtil.getParameter(request, "result");
		
		// �ϴ�ʧ�ܵĴ�������
		String errorMsg = RequestUtil.getParameter(request, "ErrorMsg");
		
		// �ϴ��ļ��������λ�ú��ļ��������ƣ�data/048BC966C0A8AD0100000002432820.txt 
		// (����data����Servlet�����õĽ����ϴ��ļ���λ�ã�048BC966C0A8AD0100000002432820.txt ��QDK���ɵ�����ļ�����)
		String fileName = RequestUtil.getParameter(request, "FM_fileSaveURL");
		//- ���ϼ��ǽϳ���ϵͳ����
		
		// ���½�ʵ�ְ��ϴ����ļ��ļ����ݷ��ؿͻ�����ʾ
		FileData fd = new FileData();
		
		RequestUtil.addVar(request, "code", "404");
		RequestUtil.addVar(request, "msg", errorMsg);
		if("0".equals(uploadFileResultCode)) { // �ϴ�ʧ��
		} else {
			// ����������ϴ��ļ��ڷ������ϵľ���·��
			String absoluteFilePath = RequestUtil.getRealPath(request, "/")
				+ File.separator + fileName;
			// ֻ����.txt�ļ�
			File receiveFile = null;
			if("txt".equalsIgnoreCase(fileName.substring(fileName.lastIndexOf(".")+1, fileName.length()))) {
				receiveFile = new File(absoluteFilePath);
				long fileLength = receiveFile.length();
				fd.setFileLength(fileLength);
				fd.setFileName(receiveFile.getName());
				StringBuilder fileContent = new StringBuilder();
				BufferedReader br = null;
				String lineSeperator = "<br/>";
				try {
					br = new BufferedReader(new InputStreamReader(new FileInputStream(receiveFile)));
					String line = null;
					while(null != (line = br.readLine())) {
						fileContent.append(line).append(lineSeperator);
					}
					fd.setContent(fileContent.toString());
					RequestUtil.addVar(request, "code", "200");
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if(null != br) {
						try {
							br.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
				
			} else {
				if(null != receiveFile) {
					receiveFile.delete();
				}
				RequestUtil.addVar(request, "code", "404");
				RequestUtil.addVar(request, "msg", "�ϴ��Ĳ���.txt�ı��ļ�");
			}
		}
		RequestUtil.addVar(request, "data", JSONObject.toJSON(fd).toString());
		
		return new ActionClassResultDTO();
	}

	public static class FileData {
		private String fileName;
		private long fileLength;
		private String content;
		
		public FileData() {}
		
		public String getFileName() {
			return fileName;
		}
		public void setFileName(String fileName) {
			this.fileName = fileName;
		}
		public long getFileLength() {
			return fileLength;
		}
		public void setFileLength(long fileLength) {
			this.fileLength = fileLength;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
	}
}
