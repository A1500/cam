package com.inspur.cams.fis.base.cmd;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.lob.Blob;
import com.inspur.cams.fis.base.data.FisImportData;
import com.inspur.cams.fis.base.domain.IFisImportDataDomain;
import com.inspur.cams.fis.util.DataExport;

/**
 * 数据上报信息查询cmd
 * @author 
 * @date Mon Apr 16 15:35:06 GMT+08:00 2012
 */
public class FisImportDataQueryCmd extends BaseQueryCommand {

	private IFisImportDataDomain fisImportDataDomain = ScaComponentFactory
			.getService(IFisImportDataDomain.class, "fisImportDataDomain/fisImportDataDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisImportDataDomain.query(pset);
	}
	
	/**
	 * @Description: 查询辖区各馆上报情况
	 * @author xuexzh
	 */
	public DataSet queryForImport() {
		ParameterSet pset = getParameterSet();
		return fisImportDataDomain.queryForImport(pset);
	}
	
	/**
	 * @Description: 查询辖区各馆上报情况
	 * @author xuexzh
	 */
	public DataSet queryForOrganImport() {
		ParameterSet pset = getParameterSet();
		return fisImportDataDomain.queryForOrganImport(pset);
	}
	
	/**
	 * @Description: 查询辖区各公墓上报情况
	 * @author xuexzh
	 */
	public DataSet queryForCemeImport() {
		ParameterSet pset = getParameterSet();
		return fisImportDataDomain.queryForCemeImport(pset);
	}
	
	public DataSet getContentDetail() {
		ParameterSet pset = getParameterSet();
		DataSet ds = fisImportDataDomain.query(pset);
		String sqls = "无";
		if(ds.getCount()==1) {
			FisImportData fisImportData = (FisImportData)ds.getRecord(0).toBean(FisImportData.class);
			if("0".equals(fisImportData.getIfFile())) {
				//在线
				try {
					Blob blob = (Blob)fisImportData.getUploadContent();
					sqls = new String(blob.getData(), "utf-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
					sqls = "在线文件转码报错！";
				}
			}else {
				try {
					StringBuffer logString = new StringBuffer();
					UploadFile uploadFile = fisImportData.getUploadContent();
					sqls = DataExport.encodeContent(uploadFile.getFileData(), fisImportData.getUploadUnit(), logString);
				} catch (FileNotFoundException e) {
					e.printStackTrace();
					sqls = "离线文件解析报错(未知文件)！";
				} catch (IOException e) {
					e.printStackTrace();
					sqls = "离线文件解析报错(读取文件)！";
				} catch (Exception e) {
					e.printStackTrace();
					sqls = "离线文件解析报错！";
				}
			}
			fisImportData.setDesc(sqls);
			
		}
		return ds;
	}
}