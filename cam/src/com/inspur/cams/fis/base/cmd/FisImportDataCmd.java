package com.inspur.cams.fis.base.cmd;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.base.data.FisImportData;
import com.inspur.cams.fis.base.domain.IFisImportDataDomain;
import com.inspur.cams.fis.util.DataExport;

/**
 * 数据上报信息cmd
 * 
 * @author
 * @date Mon Apr 16 15:35:06 GMT+08:00 2012
 */
public class FisImportDataCmd extends BaseAjaxCommand {

	private IFisImportDataDomain fisImportDataDomain = ScaComponentFactory
			.getService(IFisImportDataDomain.class,
					"fisImportDataDomain/fisImportDataDomain");
	
//	protected static final Log logger = LogFactory.getLog(com.inspur.cams.fis.base.cmd.FisImportDataCmd.class);
	
	/**
	 * @Description: 上传文件
	 * @author xuexzh
	 */
	public void uploadSave() {
		Map record = (Map) getParameter("record");
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();

		FisImportData fisImportData = new FisImportData();
		boolean ifUpdate = false;
		StringBuffer logString = new StringBuffer();
		if (iterator.hasNext()) {
			try {
				String key = (String)record.get("unitId");
				
				UploadFile uploadfile = iterator.next().getValue();
				if (uploadfile.getFileSize() > 10 * 1024 * 1024) {
					setReturn("result", "文件过大！");
					return;
				}

				logString.append("\n获取单位编号，开始解密..."+key);
				String sqls = DataExport.encodeContent(uploadfile.getFileData(), key, logString); //解密

				ifUpdate=true;
				fisImportData.setRecordId(IdHelp.getUUID32());
				fisImportData.setUploadTime(DateUtil.getTime());
				fisImportData.setUploadPerson(com.inspur.cams.comm.util.BspUtil.getEmpOrganId());
				fisImportData.setUploadUnit(key); 	// 需要单独写一个方法，获取单位编号(殡葬)
				fisImportData.setUploadFile(uploadfile.getFileName());
				fisImportData.setUploadDesc("");
				fisImportData.setUploadContent(uploadfile);
				fisImportData.setIfFile("1");		//0为vpn，1为文件
				
				//截取上报文件的时间戳	2012-08-01 00:00:002012-08-02 23:59:59
				String times = sqls.substring(sqls.length()-38);
				Pattern pattern = Pattern.compile("^\\d{4}\\-\\d{2}\\-\\d{2}.\\d{2}.\\d{2}.\\d{2}\\d{4}\\-\\d{2}\\-\\d{2}.\\d{2}.\\d{2}.\\d{2}$");
				Matcher matcher = pattern.matcher(times);  
				if(matcher.matches()) {
					//如果存在时间戳，则直接赋值
					fisImportData.setStartTime(times.substring(0,19));
					fisImportData.setEndTime(times.substring(19));
					sqls=sqls.substring(0,sqls.length()-38);
				}else {
					//如果无时间戳，则按文件名称分隔时间(临时，供未升级用户)
					if(uploadfile.getFileName() != null) {
						Pattern patternFileName = Pattern.compile("^.*\\(2012\\d{4}\\-2012\\d{4}\\).*$");
						Matcher matcherFileName = patternFileName.matcher(uploadfile.getFileName());  
						if(matcherFileName.matches()) {
							int pos = uploadfile.getFileName().lastIndexOf("-");
							
							StringBuffer startTime = new StringBuffer();
							startTime.append(uploadfile.getFileName().substring(pos-8, pos-4));
							startTime.append("-");
							startTime.append(uploadfile.getFileName().substring(pos-4, pos-2));
							startTime.append("-");
							startTime.append(uploadfile.getFileName().substring(pos-2, pos));
							startTime.append(" 00:00:00");
							
							StringBuffer endTime = new StringBuffer();
							endTime.append(uploadfile.getFileName().substring(pos+1, pos+5));
							endTime.append("-");
							endTime.append(uploadfile.getFileName().substring(pos+5, pos+7));
							endTime.append("-");
							endTime.append(uploadfile.getFileName().substring(pos+7, pos+9));
							endTime.append(" 23:59:59");
							
							fisImportData.setStartTime(startTime.toString());
							fisImportData.setEndTime(endTime.toString());
						}
					}
				}

				logString.append("\n解密完成...");
				if(sqls.indexOf("INSERT INTO") != -1 || sqls.indexOf("UPDATE") != -1) {
					String[] sqlArr = sqls.split(";");
					logString.append("\n分解解密后的字符串，准备执行..."+sqlArr.length);
					fisImportDataDomain.batchImport(sqlArr);
					logString.append("\n执行完成");
				}else {
					logString.append("\n上报导出文件格式错误...");
					setReturn("result", "文件格式错误，请查看导出是否正常！");
//					setReturn("result", "前:"+logString.toString());
					return;
				}
			} catch (Exception e) {
				logString.append("\n异常："+e.getMessage());
				if(e.getMessage().indexOf("ORA-00001") > -1)
					setReturn("result", "文件内容有冲突！");
				else if(e.getMessage().indexOf("CUSTOM") > -1)
					setReturn("result", "未知错误！");
				else if(e.getMessage().indexOf("Given final block not properly padded") > -1)
					setReturn("result", "文件解析错误，请查看所选殡仪馆是否正确！");
				else
					setReturn("result", "解析文件错误！"+e.getMessage());
				
//				setReturn("result", logString.toString());
				return;
			}
		}
		
		//如果正常导入完毕，插入更新记录
		if(ifUpdate) {
			fisImportDataDomain.insert(fisImportData);
			logString.append("\n上传记录已存");
		}
		
//		setReturn("result", "OK\n"+logString.toString());
		setReturn("result", "OK");
	}

	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisImportData fisImportData = (FisImportData) record
				.toBean(FisImportData.class);
		fisImportDataDomain.insert(fisImportData);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisImportData fisImportData = (FisImportData) record
				.toBean(FisImportData.class);
		fisImportDataDomain.update(fisImportData);
	}

	// 删除
	public void delete() {
		String recordId = (String) getParameter("recordId");
		fisImportDataDomain.delete(recordId);
	}

}