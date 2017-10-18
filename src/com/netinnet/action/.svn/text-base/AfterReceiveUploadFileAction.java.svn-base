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
 * 接收上传文件之后进行的逻辑操作
 * */
public class AfterReceiveUploadFileAction implements ActionClass
{

	public ActionClassResultDTO execute(HttpServletRequest request) {
		// 下述参数是由 cn.netinnet.qdk.action.doUploadDataFile 执行完上传动作之后传递过来的参数
		// 表示文件上传结果，0 - 上传文件失败
		String uploadFileResultCode = RequestUtil.getParameter(request, "result");
		
		// 上传失败的错误描述
		String errorMsg = RequestUtil.getParameter(request, "ErrorMsg");
		
		// 上传文件所保存的位置含文件名，类似：data/048BC966C0A8AD0100000002432820.txt 
		// (其中data是在Servlet中配置的接收上传文件的位置，048BC966C0A8AD0100000002432820.txt 是QDK生成的随机文件名称)
		String fileName = RequestUtil.getParameter(request, "FM_fileSaveURL");
		//- 已上即是较常用系统参数
		
		// 以下将实现把上传的文件文件内容返回客户端显示
		FileData fd = new FileData();
		
		RequestUtil.addVar(request, "code", "404");
		RequestUtil.addVar(request, "msg", errorMsg);
		if("0".equals(uploadFileResultCode)) { // 上传失败
		} else {
			// 获得所接收上传文件在服务器上的绝对路径
			String absoluteFilePath = RequestUtil.getRealPath(request, "/")
				+ File.separator + fileName;
			// 只处理.txt文件
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
				RequestUtil.addVar(request, "msg", "上传的不是.txt文本文件");
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
