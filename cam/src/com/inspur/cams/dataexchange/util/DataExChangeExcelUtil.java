package com.inspur.cams.dataexchange.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.util.regex.Pattern;

import jxl.Sheet;
import jxl.Workbook;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.sam.data.SamBankAccount;

/**
 * @title Excel导入处理
 * @author YLL
 * @since 2013年6月18日 
 */
public class DataExChangeExcelUtil extends BaseAjaxCommand{
	
public void importExcel() {
		
		String erro = "";
		Boolean verify = true;
		
		StringBuffer idCardSQL = new StringBuffer("");
		
		MultipartRequestWrapper request = (MultipartRequestWrapper) getRequest();
		Map<String, UploadFile> map = request.getUploadFiles();
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadFile = iterator.next().getValue();
		Workbook book = null;
		try {
			book = Workbook.getWorkbook(uploadFile.getInputStream());
			for (int k = 0; k < 1; k++) {
				Sheet sheet = book.getSheet(0);
				if(!("身份证号码".equals(sheet.getCell(0, 0).getContents()))){
					verify=false;
					erro = "模版第1行中第1列列名不正确！";
					break;
				}
				
				System.out.println("sheet.getRows()="+sheet.getRows());
				
				if(sheet.getRows() > 200){
					verify=false;
					erro = "模版中的行数已经超过200行！";
					break;
				}
				
				for (int i = 1; i < sheet.getRows(); i++) {
					//判断第1列
					if(sheet.getCell(0, i).getContents().trim().length()>18){
						verify=false;
						erro = "模版第"+(i+1)+"行中的“身份证号码”长度不能超出18位数字！";
						break;
					}else if(sheet.getCell(0, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\dX|x]{" + sheet.getCell(0, i).getContents().trim().length() + "}", sheet.getCell(0, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的身份证号码为不正确的身份证号码！";
							break;
						}else{
							idCardSQL.append(sheet.getCell(0, i).getContents().trim());
							idCardSQL.append(",");
						}
					}
					
				}
			}
			if(!verify){
				this.setReturn("erro", erro);
			}else{
				this.setReturn("idCards",idCardSQL.toString().substring(0, idCardSQL.length()-1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(book!=null){
				book.close();
			}
		}
	}
}
