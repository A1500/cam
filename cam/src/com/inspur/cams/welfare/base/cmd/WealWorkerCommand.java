package com.inspur.cams.welfare.base.cmd;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.util.regex.Pattern;

import jxl.Sheet;
import jxl.Workbook;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.support.WealWorkerDao;
import com.inspur.cams.welfare.base.data.WealWorker;
import com.inspur.cams.welfare.base.domain.IWealWorkerDomain;

/**
 * @title:WealWorkerCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealWorkerCommand extends BaseAjaxCommand{
	private WealWorkerDao dao = (WealWorkerDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealWorkerDao");
	IWealWorkerDomain service = ScaComponentFactory.getService(IWealWorkerDomain.class,
	"wealWorkerDomain/wealWorkerDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		WealWorker dataBean=(WealWorker)record.toBean(WealWorker.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealWorker dataBean=(WealWorker)record.toBean(WealWorker.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void del() {
		String workerId=(String) getParameter("workerId");
		service.delete(workerId);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealWorker> list = new ArrayList<WealWorker>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealWorker dataBean = (WealWorker) records[i].toBean(WealWorker.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	@Trans
	public void saveNewWorker(){
		String unitId=(String) getParameter("unitId");
		String taskCodeOld=(String) getParameter("taskCodeOld");
		String taskCode=(String) getParameter("taskCode");
		Date now = new Date(); 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//可以方便地修改日期格式 
		String modTime = dateFormat.format(now); 
		ParameterSet pset=new ParameterSet();
		pset.setParameter("TASK_CODE@=", taskCodeOld);
		DataSet ds=dao.query(pset);
		if(ds.getCount()>0){
			for(int i=0;i<ds.getCount();i++){
				WealWorker dataBean=(WealWorker)ds.getRecord(i).toBean(WealWorker.class);
				dataBean.setWorkerId(IdHelp.getUUID32());
				dataBean.setTaskCode(taskCode);
				dataBean.setModTime(modTime);
				dao.insert(dataBean);
			}
		}
	}
public void importExcel() {
		
		String erro = "";
		boolean editState = false;
		boolean addState = false;
		Boolean verify = true;
		String taskcode = "";
		String workerId = "";
		DataSet dataSet = new DataSet();
		ParameterSet pset = getParameterSet();
		WealWorker dataBean = new WealWorker();
		
		MultipartRequestWrapper request = (MultipartRequestWrapper) getRequest();
		Map<String, UploadFile> map = request.getUploadFiles();
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadFile = iterator.next().getValue();
		Workbook book = null;
		taskcode = (String)pset.getParameter("taskCode");
		try {
			List<WealWorker> workerAddList = new ArrayList<WealWorker>();
			List<WealWorker> workerEditList = new ArrayList<WealWorker>();
			
			book = Workbook.getWorkbook(uploadFile.getInputStream());
			for (int k = 0; k < 1; k++) {
				Sheet sheet = book.getSheet(0);
				if(!("姓名".equals(sheet.getCell(0, 0).getContents()))){
					verify=false;
					erro = "模版第1行中第1列列名不正确！";
					break;
				}
				if(!("身份证号".equals(sheet.getCell(1, 0).getContents()))){
					verify=false;
					erro = "模版第1行中第2列列名不正确！";
					break;
				}
				if(!("性别".equals(sheet.getCell(2, 0).getContents()))){
					verify=false;
					erro = "模版第1行中第3列列名不正确！";
					break;
				}
				if(!("联系电话".equals(sheet.getCell(3, 0).getContents()))){
					verify=false;
					erro = "模版第1行中第4列列名不正确！";
					break;
				}
				if( !( "家庭住址".equals( sheet.getCell(4, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第5列列名不正确！";
					break;
				}
				if( !( "残疾类别".equals( sheet.getCell(5, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第6列列名不正确！";
					break;
				}
				if( !( "残疾等级".equals( sheet.getCell(6, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第7列列名不正确！";
					break;
				}
				if( !( "文化程度".equals( sheet.getCell(7, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第8列列名不正确！";
					break;
				}
				if( !( "入厂时间".equals( sheet.getCell(8, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第9列列名不正确！";
					break;
				}
				if( !( "入厂形式".equals( sheet.getCell(9, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第10列列名不正确！";
					break;
				}
				if( !( "职业资格等级".equals( sheet.getCell(10, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第11列列名不正确！";
					break;
				}
				if( !( "是否生产人员".equals( sheet.getCell(11, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第12列列名不正确！";
					break;
				}
				if( !( "实发工资(元/年)".equals( sheet.getCell(12, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第13列列名不正确！";
					break;
				}
				if( !( "残疾补贴(元/年)".equals( sheet.getCell(13, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第14列列名不正确！";
					break;
				}
				if( !( "发放方式".equals( sheet.getCell(14, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第15列列名不正确！";
					break;
				}
				if( !( "社会保险(五险一金)(元/年)".equals( sheet.getCell(15, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第16列列名不正确！";
					break;
				}
				if( !( "商业保险(元/年)".equals( sheet.getCell(16, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第17列列名不正确！";
					break;
				}
				if( !( "养老保险(元/年)".equals( sheet.getCell(17, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第18列列名不正确！";
					break;
				}
				if( !( "医疗保险(元/年)".equals( sheet.getCell(18, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第19列列名不正确！";
					break;
				}
				if( !( "失业保险(元/年)".equals( sheet.getCell(19, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第20列列名不正确！";
					break;
				}
				if( !( "工伤保险(元/年)".equals( sheet.getCell(20, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第21列列名不正确！";
					break;
				}
				if( !( "生育保险(元/年)".equals( sheet.getCell(21, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第22列列名不正确！";
					break;
				}
				if( !( "住房公积金(元/年)".equals( sheet.getCell(22, 0).getContents() ) ) ){
					verify=false;
					erro = "模版第1行中第23列列名不正确！";
					break;
				}
				for (int i = 1; i < sheet.getRows(); i++) {
					if(sheet.getCell(0, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第1列“姓名”不能为空！";
						break;
					}
					//判断第2列
					if(sheet.getCell(1, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第2列“身份证号码”不能为空！";
						break;
					}
					if(sheet.getCell(1, i).getContents().trim().length()!=18 && sheet.getCell(1, i).getContents().trim().length()!=15){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第2列“身份证号码”长度应该为15位或18位！";
						break;
					}
					if(sheet.getCell(1, i).getContents().trim().length()!=0){
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
						erro = "模版第"+(i+1)+"行中的第3列“性别”不能为空！";
						break;
					}
					
					if(sheet.getCell(2, i).getContents().trim().length()==3){
						if(sheet.getCell(2, i).getContents().trim().indexOf("-")<1){
							verify=false;
							erro = "模版第"+(i+1)+"行中的第3列“性别”格式不正确！";
							break;
						}
						
					}else{
						verify=false;	
						erro = "模版第"+(i+1)+"行中的第3列“性别”格式不正确！";
						break;
					}
					
					if(sheet.getCell(5, i).getContents().trim().length()!=0){
						if(sheet.getCell(5, i).getContents().trim().length()==7){
							if(sheet.getCell(5, i).getContents().trim().indexOf("-")<1){
								verify=false;
								erro = "模版第"+(i+1)+"行中的第6列“残疾类别”格式不正确！";
								break;
							}
							
						}else{
							verify=false;
							erro = "模版第"+(i+1)+"行中的第6列“残疾类别”格式不正确！";
							break;
						}
					}
					if(sheet.getCell(6, i).getContents().trim().length()!=0){
						if(sheet.getCell(6, i).getContents().trim().length()==7){
							if(sheet.getCell(6, i).getContents().trim().indexOf("-")<1){
								verify=false;
								erro = "模版第"+(i+1)+"行中的第7列“残疾等级”格式不正确！";
								break;
							}
							
						}else{
							verify=false;
							erro = "模版第"+(i+1)+"行中的第7列“残疾等级”格式不正确！";
							break;
						}
					}
					if(sheet.getCell(7, i).getContents().trim().length()!=0){
						if(sheet.getCell(7, i).getContents().trim().length()>=5){
							if(sheet.getCell(7, i).getContents().trim().indexOf("-")<1){
								verify=false;
								erro = "模版第"+(i+1)+"行中的第8列“文化程度”格式不正确！";
								break;
							}
						}else{
							verify=false;
							erro = "模版第"+(i+1)+"行中的第8列“文化程度”格式不正确！";
							break;
						}
					}
					if(sheet.getCell(8, i).getContents().trim().length()!=0){
						if(sheet.getCell(8, i).getContents().trim().length()!=10){
							verify=false;
							erro = "模版第"+(i+1)+"行中的第9列“入厂时间”格式不正确！";
							break;
						}
						/*
						if(sheet.getCell(8, i).getContents().trim().length()==10){
							if(sheet.getCell(8, i).getContents().trim().indexOf("-")<1){
								verify=false;
								erro = "模版第"+(i+1)+"行中的第9列“入厂时间”格式不正确！";
								break;
							}
						}
						*/
					}
					if(sheet.getCell(9, i).getContents().trim().length()!=0){
						if(sheet.getCell(9, i).getContents().trim().length()<5){
							verify=false;
							erro = "模版第"+(i+1)+"行中的第10列“入厂形式”格式不正确！";
							break;
						}
						
					}
					if(sheet.getCell(10, i).getContents().trim().length()!=0){
						if(sheet.getCell(10, i).getContents().trim().length()==5){
							if(sheet.getCell(10, i).getContents().trim().indexOf("-")<1){
								verify=false;
								erro = "模版第"+(i+1)+"行中的第11列“职业资格等级”格式不正确！";
								break;
							}
						}else{
							verify=false;
							erro = "模版第"+(i+1)+"行中的第11列“职业资格等级”格式不正确！";
							break;
						}
					}
					if(sheet.getCell(11, i).getContents().trim().length()==3){
						if(sheet.getCell(11, i).getContents().trim().indexOf("-")<1){
							verify=false;
							erro = "模版第"+(i+1)+"行中的第12列“是否生产人员”格式不正确！";
							break;
						}
					}
					if(sheet.getCell(11, i).getContents().trim().length()!=3 && sheet.getCell(11, i).getContents().trim().length()!=0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第12列“是否生产人员”格式不正确！";
						break;
					}
					if(sheet.getCell(14, i).getContents().trim().length()!=0){
						if(!("-".equals(sheet.getCell(14, i).getContents().trim().substring(1, 2)))){
							verify=false;
							erro = "模版第"+(i+1)+"行中的第15列“发放方式”格式不正确！";
							break;
						}
						
					}
					//判断第13列
					if(sheet.getCell(12, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第13列“实发工资(元/年)”不能为空！";
						break;
					}else if(sheet.getCell(12, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\d.]{1,12}", sheet.getCell(12, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第13列为不正确的数字格式！";
							break;
						}
					}
					
					//判断第16列
					if(sheet.getCell(15, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第16列“社会保险(五险一金)(元/年)”不能为空！";
						break;
					}else if(sheet.getCell(15, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\d.]{1,12}", sheet.getCell(15, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第16列为不正确的数字格式！";
							break;
						}
					}
					//判断第17列
					if(sheet.getCell(16, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第17列“商业保险(元/年)”不能为空！";
						break;
					}else if(sheet.getCell(16, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\d.]{1,12}", sheet.getCell(16, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第17列为不正确的数字格式！";
							break;
						}
					}
					//判断第18列
					if(sheet.getCell(17, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第18列“养老保险(元/年)”不能为空！";
						break;
					}else if(sheet.getCell(17, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\d.]{1,12}", sheet.getCell(17, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第18列为不正确的数字格式！";
							break;
						}
					}
					//判断第19列
					if(sheet.getCell(18, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第19列“医疗保险(元/年)”不能为空！";
						break;
					}else if(sheet.getCell(18, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\d.]{1,12}", sheet.getCell(18, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第19列为不正确的数字格式！";
							break;
						}
					}
					//判断第20列
					if(sheet.getCell(19, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第20列“失业保险(元/年)”不能为空！";
						break;
					}else if(sheet.getCell(19, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\d.]{1,12}", sheet.getCell(19, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第20列为不正确的数字格式！";
							break;
						}
					}
					//判断第21列
					if(sheet.getCell(20, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第21列“工伤保险(元/年)”不能为空！";
						break;
					}else if(sheet.getCell(20, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\d.]{1,12}", sheet.getCell(20, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第21列为不正确的数字格式！";
							break;
						}
					}
					//判断第22列
					if(sheet.getCell(21, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第22列“生育保险(元/年)”不能为空！";
						break;
					}else if(sheet.getCell(21, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\d.]{1,12}", sheet.getCell(21, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第22列为不正确的数字格式！";
							break;
						}
					}
					//判断第23列
					if(sheet.getCell(22, i).getContents().trim().length()==0){
						verify=false;
						erro = "模版第"+(i+1)+"行中的第23列“住房公积金(元/年)”不能为空！";
						break;
					}else if(sheet.getCell(22, i).getContents().trim().length()!=0){
						boolean isNum = Pattern.matches("[\\d.]{1,12}", sheet.getCell(22, i).getContents().trim());
						if (!isNum) {
							verify=false;
							erro = "模版第"+(i+1)+"行中的第23列为不正确的数字格式！";
							break;
						}
					}
					
					
					//维护员工信息表
					workerId = IdHelp.getUUID32();
					String[] sex = sheet.getCell(2, i).getContents().split("-");
					String[] cjlb = sheet.getCell(5, i).getContents().split("-");
					String[] cjdj = sheet.getCell(6, i).getContents().split("-");
					String[] whcd = sheet.getCell(7, i).getContents().split("-");
					String[] rcxs = sheet.getCell(9, i).getContents().split("-");
					String[] zyzgdj = sheet.getCell(10, i).getContents().split("-");
					String[] sfscry = sheet.getCell(11, i).getContents().split("-");
					String[] fffs = sheet.getCell(14, i).getContents().split("-");
					pset.clear();
					pset.setParameter("ID_CARD@=",sheet.getCell(1,i).getContents().trim());
					pset.setParameter("TASK_CODE@=",taskcode);
					dataSet = dao.query(pset);
					if(dataSet.getCount() > 0){
						dataBean = (WealWorker) dataSet.getRecord(0).toBean(WealWorker.class);
						dataBean.setName(sheet.getCell(0, i).getContents().trim());
						dataBean.setIdCard(sheet.getCell(1, i).getContents().trim());
						dataBean.setSex(sex[0]);
						dataBean.setPhone(sheet.getCell(3, i).getContents().trim());
						dataBean.setAddress(sheet.getCell(4, i).getContents().trim());
						if(cjlb.length<1){
							dataBean.setDisabilityType("");
						}else{
							dataBean.setDisabilityType(cjlb[0]);
						}
						     
						if(cjdj.length<1){
							dataBean.setDisabilityLevel("");
						}else{
							dataBean.setDisabilityLevel(cjdj[0]);
						}
						if(whcd.length<1){
							dataBean.setEducation("");
						}else{
							dataBean.setEducation(whcd[0]);
						}
						if(sfscry.length<1){
							//dataBean.setIfProductor("");
						}else{
							dataBean.setIfProductor(sfscry[0]);
						}
						String sss = sheet.getCell(8, i).getContents().trim();
						if("".equals(sss)){
							dataBean.setEntryDate("");
						}else{
							String yyyy = sss.substring(0, 4);
							String mm = sss.substring(5, 7);
							String dd = sss.substring(8, 10);
							String entyDate = yyyy+"-"+mm+"-"+dd;
							dataBean.setEntryDate(entyDate);
						}
						
						if(rcxs.length<1){
							dataBean.setEntryType("");
						}else{
							dataBean.setEntryType(rcxs[0]);
						}
						if(zyzgdj.length<1){
							dataBean.setJobLevel("");
						}else{
							dataBean.setJobLevel(zyzgdj[0]);
						}
						dataBean.setRealWages(new BigDecimal(sheet.getCell(12, i).getContents().trim()));
						String s = sheet.getCell(13, i).getContents().trim();
						if("".equals(s)){
							s="0";
						}
						dataBean.setDisSubsidy(new BigDecimal(s));
						if(!"".equals(sheet.getCell(14, i).getContents().trim())){
							dataBean.setAllocationType(new BigDecimal(fffs[0]));
						}
						dataBean.setSocialInsurance(new BigDecimal(sheet.getCell(15, i).getContents().trim()));
						dataBean.setBusInsurance(new BigDecimal(sheet.getCell(16, i).getContents().trim()));
						dataBean.setEndowmentInsurance(new BigDecimal(sheet.getCell(17, i).getContents().trim()));
						dataBean.setMedicalInsurance(new BigDecimal(sheet.getCell(18, i).getContents().trim()));
						dataBean.setUnemployedInsurance(new BigDecimal(sheet.getCell(19, i).getContents().trim()));
						dataBean.setInjuryInsurance(new BigDecimal(sheet.getCell(20, i).getContents().trim()));
						dataBean.setMaternityInsurance(new BigDecimal(sheet.getCell(21, i).getContents().trim()));
						dataBean.setHousingFund(new BigDecimal(sheet.getCell(22, i).getContents().trim()));
						dataBean.setCorporationType("2");
						workerEditList.add(dataBean);
						editState = true;
					}else{
						dataBean = new WealWorker();
						dataBean.setWorkerId(workerId);
						dataBean.setTaskCode(taskcode);
						dataBean.setName(sheet.getCell(0, i).getContents().trim());
						dataBean.setIdCard(sheet.getCell(1, i).getContents().trim());
						dataBean.setSex(sex[0]);
						dataBean.setPhone(sheet.getCell(3, i).getContents().trim());
						dataBean.setAddress(sheet.getCell(4, i).getContents().trim());
						if(cjlb.length<1){
							dataBean.setDisabilityType("");
						}else{
							dataBean.setDisabilityType(cjlb[0]);
						}
						     
						if(cjdj.length<1){
							dataBean.setDisabilityLevel("");
						}else{
							dataBean.setDisabilityLevel(cjdj[0]);
						}
						if(whcd.length<1){
							dataBean.setEducation("");
						}else{
							dataBean.setEducation(whcd[0]);
						}
						if(sfscry.length<1){
							//ataBean.setIfProductor("");
						}else{
							dataBean.setIfProductor(sfscry[0]);
						}
						String sss = sheet.getCell(8, i).getContents().trim();
						if("".equals(sss)){
							dataBean.setEntryDate("");
						}else{
							String yyyy = sss.substring(0, 4);
							String mm = sss.substring(5, 7);
							String dd = sss.substring(8, 10);
							String entyDate = yyyy+"-"+mm+"-"+dd;
							dataBean.setEntryDate(entyDate);
						}
						if(rcxs.length<1){
							dataBean.setEntryType("");
						}else{
							dataBean.setEntryType(rcxs[0]);
						}
						if(zyzgdj.length<1){
							dataBean.setJobLevel("");
						}else{
							dataBean.setJobLevel(zyzgdj[0]);
						}
						//dataBean.setIfProductor(sfscry[0]);
						dataBean.setRealWages(new BigDecimal(sheet.getCell(12, i).getContents().trim()));
						String s = sheet.getCell(13, i).getContents().trim();
						if("".equals(s)){
							s="0";
						}
						dataBean.setDisSubsidy(new BigDecimal(s));
						if(!"".equals(sheet.getCell(14, i).getContents().trim())){
							dataBean.setAllocationType(new BigDecimal(fffs[0]));
						}
						
						dataBean.setSocialInsurance(new BigDecimal(sheet.getCell(15, i).getContents().trim()));
						dataBean.setBusInsurance(new BigDecimal(sheet.getCell(16, i).getContents().trim()));
						dataBean.setEndowmentInsurance(new BigDecimal(sheet.getCell(17, i).getContents().trim()));
						dataBean.setMedicalInsurance(new BigDecimal(sheet.getCell(18, i).getContents().trim()));
						dataBean.setUnemployedInsurance(new BigDecimal(sheet.getCell(19, i).getContents().trim()));
						dataBean.setInjuryInsurance(new BigDecimal(sheet.getCell(20, i).getContents().trim()));
						dataBean.setMaternityInsurance(new BigDecimal(sheet.getCell(21, i).getContents().trim()));
						dataBean.setHousingFund(new BigDecimal(sheet.getCell(22, i).getContents().trim()));
						dataBean.setCorporationType("2");
						workerAddList.add(dataBean);
						addState = true;
					}
				}
			}
			if(verify){
				if(addState){
					service.batchInsert(workerAddList);
				}
				if(editState){
					service.batchUpdate(workerEditList);
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
