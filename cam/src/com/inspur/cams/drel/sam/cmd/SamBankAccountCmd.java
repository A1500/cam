package com.inspur.cams.drel.sam.cmd;

import java.util.*;
import java.util.Map.Entry;
import java.util.regex.Pattern;

import jxl.Sheet;
import jxl.Workbook;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.jdbc.BaseinfoFamilyArchiveDao;
import com.inspur.cams.drel.sam.dao.jdbc.SamBankAccountDao;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.domain.ISamBankAccountDomain;
/**
 * @title:SamBankAccountCommand
 * @description:
 * @author:
 * @since:2012-05-18
 * @version:1.0
*/
public class SamBankAccountCmd extends BaseAjaxCommand{
	private SamBankAccountDao dao = (SamBankAccountDao) DaoFactory
			.getDao("com.inspur.cams.drel.sam.dao.jdbc.SamBankAccountDao");
	
	private BaseinfoFamilyArchiveDao baseinfoFamilyArchiveDao = (BaseinfoFamilyArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.jdbc.BaseinfoFamilyArchiveDao");
	
	ISamBankAccountDomain service = ScaComponentFactory.getService(ISamBankAccountDomain.class,
	"SamBankAccountDomain/SamBankAccountDomain");
	
	public void insert() {
		ParameterSet pset = new ParameterSet();
		SamBankAccount dataBean = new SamBankAccount();
		Record record = (Record) getParameter("record");
		String familyId = (String) getParameter("familyId");
		//String assistanceType = (String) getParameter("assistanceType");
		
		pset.setParameter("FAMILY_ID@=", familyId);
		DataSet ds = service.query(pset);
		if(ds.getCount()>0){
			dataBean = (SamBankAccount)ds.getRecord(0).toBean(SamBankAccount.class);
			dataBean.setReleaseWay("01");
			dataBean.setAccountStatus("1");
			//dataBean.setAssistanceType(assistanceType);
			dataBean.setBank((String)record.get("bank"));
			dataBean.setAccountName((String)record.get("accountName"));
			dataBean.setAccountNumber((String)record.get("accountNumber"));
			service.update(dataBean);
		}else{
			dataBean.setAccountId(IdHelp.getUUID32());
			dataBean.setFamilyId(familyId);
			dataBean.setReleaseWay("01");
			dataBean.setAccountStatus("1");
			//dataBean.setAssistanceType(assistanceType);
			dataBean.setBank((String)record.get("bank"));
			dataBean.setAccountName((String)record.get("accountName"));
			dataBean.setAccountNumber((String)record.get("accountNumber"));
			service.insert(dataBean);
		}
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamBankAccount dataBean=(SamBankAccount)record.toBean(SamBankAccount.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamBankAccount> list = new ArrayList<SamBankAccount>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamBankAccount dataBean = (SamBankAccount) records[i].toBean(SamBankAccount.class);
			list.add(dataBean);
		}
		dao.save(list);
	}
	/**
	 * @Title: importExcel 
	 * @Description: TODO(批量维护银行账户信息) 
	 * @author wangziming
	 */
	public void importExcel() {
		
		String erro = "";
		boolean editState = false;
		boolean addState = false;
		Boolean verify = true;
		String accountId = "";
		String familyId = "";
		DataSet ds = new DataSet();
		DataSet dataSet = new DataSet();
		ParameterSet pset = new ParameterSet();
		SamBankAccount dataBean = new SamBankAccount();
		
		MultipartRequestWrapper request = (MultipartRequestWrapper) getRequest();
		Map<String, UploadFile> map = request.getUploadFiles();
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadFile = iterator.next().getValue();
		Workbook book = null;
		try {
			List<SamBankAccount> bankAccountAddList = new ArrayList<SamBankAccount>();
			List<SamBankAccount> bankAccountEditList = new ArrayList<SamBankAccount>();
			
			book = Workbook.getWorkbook(uploadFile.getInputStream());
			for (int k = 0; k < 1; k++) {
				Sheet sheet = book.getSheet(0);
				if(!("户主姓名".equals(sheet.getCell(0, 0).getContents()))){
					verify=false;
					erro = "模版第1行中第1列列名不正确！";
					break;
				}
				if(!("身份证号码".equals(sheet.getCell(1, 0).getContents()))){
					verify=false;
					erro = "模版第1行中第2列列名不正确！";
					break;
				}
				if(!("开户银行".equals(sheet.getCell(2, 0).getContents()))){
					verify=false;
					erro = "模版第1行中第3列列名不正确！";
					break;
				}
				if(!("账户名称".equals(sheet.getCell(3, 0).getContents()))){
					verify=false;
					erro = "模版第1行中第4列列名不正确！";
					break;
				}
				if( !( "银行账号".equals( sheet.getCell(4, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第5列列名不正确！";
					break;
				}
				for (int i = 1; i < sheet.getRows(); i++) {
					//判断第1列
					if(sheet.getCell(0, i).getContents().trim().length()==0){
						//verify=false;
						//erro = "模版第"+(i+1)+"行中的第1列“姓名”不能为空！";
						break;
					}
					//判断第2列
					if(sheet.getCell(1, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第2列“身份证号码”不能为空！";
						break;
					}else if(sheet.getCell(1, i).getContents().trim().length()>18){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第2列“身份证号码”长度不能超出18位数字！";
						break;
					}else if(sheet.getCell(1, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\dX|x]{" + sheet.getCell(1, i).getContents().trim().length() + "}", sheet.getCell(1, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第2列为不正确的身份证号码！";
							break;
						}
					}
					//判断第3列
					if(sheet.getCell(2, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第3列“开户银行”不能为空！";
						break;
					}
					//判断第4列
					if(sheet.getCell(3, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第4列“账户名称”不能为空！";
						break;
					}
					//判断第5列
					if(sheet.getCell(4, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第5列“银行帐号”不能为空！";
						break;
					}
					//维护银行账户信息表
					accountId = IdHelp.getUUID32();
					String[] banks = sheet.getCell(2, i).getContents().split("-");
					pset.clear();
					pset.setParameter("FAMILY_CARD_NO@=",sheet.getCell(1,i).getContents().trim());
					ds = baseinfoFamilyArchiveDao.query(pset);
					if(ds.getCount() > 0){
						String familyName=(String)ds.getRecord(0).get("familyName");
						if( !(familyName.equals(sheet.getCell(0,i).getContents().trim())) ){
							verify=false;
							erro = "模版第"+(i+1)+"行中的“户主姓名”与“身份证号”不一致！";
							break;
						}
						pset.clear();
						familyId = (String) ds.getRecord(0).get("familyId");
						pset.setParameter("FAMILY_ID@=",familyId);
						dataSet = dao.query(pset);
						if(dataSet.getCount() > 0){
							dataBean = (SamBankAccount) dataSet.getRecord(0).toBean(SamBankAccount.class);
							dataBean.setAccountId(accountId);
							dataBean.setBank(banks[0]);//开户银行
							dataBean.setAccountStatus("1");
							dataBean.setAccountName(sheet.getCell(3, i).getContents().trim());//银行开户名称
							dataBean.setAccountNumber(sheet.getCell(4, i).getContents().trim());//银行帐号
							bankAccountEditList.add(dataBean);
							editState = true;
						}else{
							dataBean = new SamBankAccount();
							dataBean.setFamilyId(familyId);
							dataBean.setAccountId(accountId);
							dataBean.setReleaseWay("01");
							dataBean.setAccountStatus("1");
							//dataBean.setAssistanceType("01");
							dataBean.setBank(banks[0]);//开户银行
							dataBean.setAccountName(sheet.getCell(3, i).getContents().trim());//银行开户名称
							dataBean.setAccountNumber(sheet.getCell(4, i).getContents().trim());//银行帐号
							bankAccountAddList.add(dataBean);
							addState = true;
						}
					}else{
						verify=false;
						erro = "模版第"+(i+1)+"行的低保信息不存在，不能维护银行账户信息！";
						break;
					}
				}
			}
			if(verify){
				if(addState){
					service.batchInsert(bankAccountAddList);
				}
				if(editState){
					service.batchUpdate(bankAccountEditList);
				}
			}else{
				this.setReturn("erro", erro);
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