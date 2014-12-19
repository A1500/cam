package com.inspur.cams.sorg.manage.cmd;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.core.BusinessException;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;


import com.inspur.cams.comm.dicm.IDicDao;
import com.inspur.cams.sorg.base.dao.jdbc.SomOrganDao;
import com.inspur.cams.sorg.base.dao.jdbc.SomPartyDao;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomParty;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.RecordToBeanUtil;
public class SomPartyHisImportCmd extends BaseAjaxCommand {

	/**
	 * 导入党建历史数据Excel
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	@Trans
	public void importPartyHisExcel() throws FileNotFoundException, IOException {
		Record rec = (Record)getParameter("upLoadViewRecord");//取得前台传来的Record对象
		SomParty partyModel = (SomParty)rec.toBean(SomParty.class);
		UploadFile uploadFile = partyModel.getUploadFile();//取得上传文件
		if(uploadFile == null) {
			throw new BusinessException("无法取得上传文件！");//异常情况 无法取得上传文件
		}
		InputStream importExcel = uploadFile.getInputStream();
		processImportPartyExcel(importExcel);
	}
	private void processImportPartyExcel(InputStream importExcel) {
		
		List<SomParty> partyHisList = new ArrayList<SomParty>();
		StringBuffer errorList = new StringBuffer();
		SomPartyDao partyDao = (SomPartyDao)DaoFactory.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomPartyDao");
		SomOrganDao somOrganDao=(SomOrganDao)DaoFactory.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomOrganDao");
		//String area = BspUtil.getCorpOrgan().getOrganCode();
		//String organId = BspUtil.getCorpOrganId();
		IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		try {
			Workbook wb = Workbook.getWorkbook(importExcel);
			int sheetNum=wb.getNumberOfSheets();
			int sucCount=0;//成功导入条数
			int sumCount=0;//总记录数
			int existCount=0;//数据库中已经存在的记录数
			errorList.setLength(0);
			System.out.println("sheetNum====="+sheetNum);
			
		for(int k=0;k<sheetNum;k++){
			Sheet sheet = wb.getSheet(k);
			boolean isNullRow=false;//是否空数据行
			
			System.out.println("k====="+k);
			System.out.println("sheet.getRows()===="+sheet.getRows());
			/*if(sheet.getRows()!=63){
				throw new BusinessException("请上传模板文件！");//判断是否为模板文件
			}*/
			for(int i=11; i<sheet.getRows(); i++) {
				SomParty somPartyRec = new SomParty();
				isNullRow=false;//初始化为false：表示有数据行
				int j=i-10;
				//*******************解析Excel的内容
				if("".equals(sheet.getCell(1, i).getContents().trim())){//社会组织名称为空
					isNullRow=true;//判断为空数据行
					break;
				}else{
					sumCount++;
					//*******************根据社会名称判断是否已经存在于数据库中
					ParameterSet pset =new ParameterSet();
					pset.setParameter("SORG_NAME", sheet.getCell(1, i).getContents().trim());
					DataSet ds=partyDao.query(pset);
					if(ds.getCount() > 0){
						existCount++;
						errorList.append("第"+k+"页,序号第"+j+"行：社会组织名称为'"+sheet.getCell(1, i).getContents().trim()+"'的党建信息已存在;");
						isNullRow=true;
						continue;
					}
					/*else{
						//*******************根据社会名称判断是否存在相应的社会组织信息
						ParameterSet set =new ParameterSet();
						set.setParameter("CN_NAME", sheet.getCell(1, i).getContents().trim());
						DataSet dset=somOrganDao.query(set);
						if(dset.getCount() > 0){
							Record record=dset.getRecord(0);
							SomOrgan somOrgan=(SomOrgan)record.toBean(SomOrgan.class);
							somPartyRec.setSorgId(somOrgan.getSorgId());
							somPartyRec.setSorgName(sheet.getCell(1, i).getContents().trim());//社会组织名称
						}else{
							errorList.append("序号第"+j+"行：不存在社会组织名称为'"+sheet.getCell(1, i).getContents().trim()+"'的社会组织信息;");
							isNullRow=true;
							continue;
						}
					}*/
				}
				//********************社会组织名称 1*********************************
				somPartyRec.setSorgName(sheet.getCell(1, i).getContents().trim());//社会组织名称
				//********************单位地址（忽略） 2*********************************
				//********************登记证号 3*********************************
				Cell sorgCodeCell = sheet.getCell(3, i);
				/*String sorgTypeCell="社会团体";
				somPartyRec.setSorgType("S");//设置组织类别
*/				/*String sorgTypeCell="民办非企业单位";
				somPartyRec.setSorgType("M");//设置组织类别
*/				String sorgTypeCell="基金会";
				somPartyRec.setSorgType("J");//设置组织类别
				String sorgCode=sorgCodeCell.getContents().trim();
				if(!"".equals(sorgCode)){
					if(sorgCode.length()<5&&"社会团体".equals(sorgTypeCell)){
						do{
							sorgCode="0"+sorgCode;
						}while(sorgCode.length()<5);
					}
					if(sorgCode.length()<6&&("民办非企业单位".equals(sorgTypeCell)||"基金会".equals(sorgTypeCell))){
						do{
							sorgCode="0"+sorgCode;
						}while(sorgCode.length()<6);
					}
					somPartyRec.setSorgCode(sorgCode);
				}
				/*else{
					errorList.append("序号第"+j+"行："+"登记证号不能为空;");
					isNullRow=true;//置为空数据行
				}*/
				//********************业务主管单位-(忽略)4*********************************
				//********************联系电话-(忽略)5*********************************
				//********************从业人员数 6、7、8、9、10*********************************
				if(!"".equals(sheet.getCell(6, i).getContents().trim())){  //合计
					somPartyRec.setEngagedNum(new BigDecimal(sheet.getCell(6, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(7, i).getContents().trim())){  //领导成员-专
					somPartyRec.setEngagedLeaderFulltime(new BigDecimal(sheet.getCell(7, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(8, i).getContents().trim())){  //领导成员-兼
					somPartyRec.setEngagedLeaderParttime(new BigDecimal(sheet.getCell(8, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(9, i).getContents().trim())){  //工作人员-专
					somPartyRec.setEngagedMemFulltime(new BigDecimal(sheet.getCell(9, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(10, i).getContents().trim())){  //工作人员-兼
					somPartyRec.setEngagedMemParttime(new BigDecimal(sheet.getCell(10, i).getContents().trim()));
				}
				//********************组织类别-(忽略)11、12、13、14*********************************
				//********************法定代表人 15、16*********************************
				somPartyRec.setLegalPeople(sheet.getCell(15, i).getContents().trim());//法定代表人-姓名
				try{
					String politics=dao.getTextValueFromDic("DIC_POLITICAL","NAME",sheet.getCell(16, i).getContents().trim(),"CODE");
					if(!"".equals(politics)){
						somPartyRec.setPolitics(politics);//法定代表人-政治面貌
					}else{
						if("党员".equals(sheet.getCell(16, i).getContents().trim())||"中共党员".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("01");//中国共产党党员
						}
						if("民进".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("07");//中国民主促进会会员
						}
						if("民建".equals(sheet.getCell(16, i).getContents().trim())||"民建会员".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("06");//中国民主建国会会员
						}
						if("农工".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("08");//中国农工民主党党员
						}
						if("致公党".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("09");//中国致公党党员
						}
						if("民盟".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("05");//中国民主同盟盟员
						}
						if("民主党派".equals(sheet.getCell(16, i).getContents().trim())||"农工党".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("08");//中国农工民主党党员
						}
						if("九三学社".equals(sheet.getCell(16, i).getContents().trim())||"九三".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("10");//中国农工民主党党员
						}
						if("民革".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("04");//中国民主同盟盟员
						}
						if("团员".equals(sheet.getCell(16, i).getContents().trim())){
							somPartyRec.setPolitics("03");//中国民主同盟盟员
						}
					}
				}catch(Exception e) {
					e.printStackTrace();
					//throw new BusinessException("序号第"+j+"行："+"法定代表人政治面貌存在不正确的格式！");//异常情况
					errorList.append("第"+k+"页,序号第"+j+"行："+"法定代表人政治面貌存在不正确的格式;");
					isNullRow=true;//置为空数据行
				}
				//********************党组织设置 17、18*********************************
				Cell yesBuildPartyCell = sheet.getCell(17, i);//党组织设置-是
				Cell noBuildPartyCell = sheet.getCell(18, i);//党组织设置-否
				if(!"".equals(yesBuildPartyCell.getContents().trim())&&"".equals(noBuildPartyCell.getContents().trim())){
					somPartyRec.setIfBuildParty("1");
				}else if("".equals(yesBuildPartyCell.getContents().trim())&&!"".equals(noBuildPartyCell.getContents().trim())){
					somPartyRec.setIfBuildParty("0");
				}else{
					//throw new BusinessException("序号第"+j+"行："+"党组织设置，其值应该为'是'或'否'！");
					errorList.append("第"+k+"页,序号第"+j+"行："+"党组织设置，其值应该为'是'或'否';");
					isNullRow=true;//置为空数据行
				}
				//********************党建指导员信息 19、20*********************************
				somPartyRec.setInstructor(sheet.getCell(19, i).getContents().trim());//党建指导员-姓名
				somPartyRec.setInstructorWorkName(sheet.getCell(20, i).getContents().trim());//党建指导员-单位
				//********************组织建制 21、22、23、24、25*********************************
				Cell buildTypeCellDW = sheet.getCell(21, i);//组织建制-党委-党总支-党支部-党小组-临时党支部-联合支部
				Cell buildTypeCellDZZ = sheet.getCell(22, i);
				Cell buildTypeCellDZB = sheet.getCell(23, i);
				Cell buildTypeCellLS = sheet.getCell(24, i);
				Cell buildTypeCellLH = sheet.getCell(25, i);
				if(!"".equals(buildTypeCellDW.getContents().trim())){
					somPartyRec.setBuildType("0");
				}else if(!"".equals(buildTypeCellDZZ.getContents().trim())){
					somPartyRec.setBuildType("1");
				}else if(!"".equals(buildTypeCellDZB.getContents().trim())){
					somPartyRec.setBuildType("2");
				}else if(!"".equals(buildTypeCellLS.getContents().trim())){
					somPartyRec.setBuildType("4");
				}else if(!"".equals(buildTypeCellLH.getContents().trim())){
					somPartyRec.setBuildType("5");
				}
				/*else{
					//throw new BusinessException("序号第"+j+"行："+"组织建制，其值应该为'党委'、'党总支'、'党支部'、'党小组'、'临时党支部'或'联合支部'！");
					errorList.append("序号第"+j+"行："+"组织建制，其值应该为'党委'、'党总支'、'党支部'、'党小组'、'临时党支部'或'联合支部';");
					isNullRow=true;//置为空数据行
				}*/
				//********************建立党组织时间 26*********************************
				somPartyRec.setBuildDate(sheet.getCell(26, i).getContents().trim());//建立党组织时间
				//********************审批单位 27*********************************
				somPartyRec.setAuditOrgan(sheet.getCell(27, i).getContents().trim());//审批单位
				//********************党组织隶属关系 28、29、30、31、32*********************************
				Cell belongRelCellYW = sheet.getCell(28, i);//党组织隶属关系-业务主管部门-挂靠单位-行业管理-属地管理-其他
				Cell belongRelCellGK = sheet.getCell(29, i);
				Cell belongRelCellHY = sheet.getCell(30, i);
				Cell belongRelCellSD = sheet.getCell(31, i);
				Cell belongRelCellQT = sheet.getCell(32, i);
				if(!"".equals(belongRelCellYW.getContents().trim())) {
					somPartyRec.setBelongRel("0");
				}else if(!"".equals(belongRelCellGK.getContents().trim())) {
					somPartyRec.setBelongRel("1");
				}else if(!"".equals(belongRelCellHY.getContents().trim())) {
					somPartyRec.setBelongRel("4");
				}else if(!"".equals(belongRelCellSD.getContents().trim())) {
					somPartyRec.setBelongRel("2");
				}else if(!"".equals(belongRelCellQT.getContents().trim())){
					somPartyRec.setBelongRel("3");
				}
				/*else{
					//throw new BusinessException("序号第"+j+"行："+"党组织隶属关系，其值应该为'业务主管部门'、'挂靠单位'、'属地管理'或'其他'！");
					errorList.append("序号第"+j+"行："+"党组织隶属关系，其值应该为'业务主管部门'、'挂靠单位'、'行业管理'、'属地管理'或'其他';");
					isNullRow=true;//置为空数据行
				}*/
				//********************党组织负责人信息 33、34、35、36*********************************
				somPartyRec.setPartyChief(sheet.getCell(33, i).getContents().trim());//党组织负责人-姓名
				somPartyRec.setPhone(sheet.getCell(34, i).getContents().trim());//党组织负责人-电话
				//党组织负责人-社会组织职务
				try{
					somPartyRec.setSorgDuties(dao.getTextValueFromDic("DIC_SOM_DUTY","NAME",sheet.getCell(35, i).getContents().trim(),"CODE"));
				}catch(Exception e) {
					e.printStackTrace();
					//throw new BusinessException("序号第"+j+"行："+"党组织负责人社会组织职务存在不正确的格式！");//异常情况 
					errorList.append("第"+k+"页,序号第"+j+"行："+"党组织负责人社会组织职务存在不正确的格式;");
					isNullRow=true;//置为空数据行
				}
				somPartyRec.setWorkName(sheet.getCell(36, i).getContents().trim());//党组织负责人-原工作单位及职务
				//somPartyRec.setWorkDuties(sheet.getCell(36, i).getContents().trim());//党组织负责人-原工作单位职务
				
				//********************未建立党组织原因 37、38、39*********************************
				Cell nobuildReasonCellWJ = sheet.getCell(37, i);//未建立党组织原因-应建未建-不足三名党员-无党员-派驻党建指导员
				Cell nobuildReasonCellBZ = sheet.getCell(38, i);
				Cell nobuildReasonCellWDY = sheet.getCell(39, i);
				if(!"".equals(nobuildReasonCellWJ.getContents().trim())) {
					somPartyRec.setNobuildReason("0");
				}else if(!"".equals(nobuildReasonCellBZ.getContents().trim())) {
					somPartyRec.setNobuildReason("1");
				}else if(!"".equals(nobuildReasonCellWDY.getContents().trim())) {
					somPartyRec.setNobuildReason("2");
				}
				/*else {
					//throw new BusinessException("序号第"+j+"行："+"未建立党组织原因，其值应该为'应建未建'、'不足三名党员'、'无党员'或'派驻党建指导员'！");
					errorList.append("序号第"+j+"行："+"未建立党组织原因，其值应该为'应建未建'、'不足三名党员'、'无党员';");
					isNullRow=true;//置为空数据行
				}*/
				//********************党员人数 40、41、42、43、44、45、46*********************************
				if(!"".equals(sheet.getCell(40, i).getContents().trim())){  //合计
					somPartyRec.setMemberNum(new BigDecimal(sheet.getCell(40, i).getContents().trim()));//党员数
				}
				if(!"".equals(sheet.getCell(41, i).getContents().trim())){  //领导班子-专职-已转
					somPartyRec.setLeaderFulltimeOutNum(new BigDecimal(sheet.getCell(41, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(42, i).getContents().trim())){  //领导班子-专职-未转
					somPartyRec.setLeaderFulltimeNoNum(new BigDecimal(sheet.getCell(42, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(43, i).getContents().trim())){  //领导班子-兼职
					somPartyRec.setLeaderParttimeNum(new BigDecimal(sheet.getCell(43, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(44, i).getContents().trim())){  //工作人员-专职-已转
					somPartyRec.setMemFulltimeOutNum(new BigDecimal(sheet.getCell(44, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(45, i).getContents().trim())){  //工作人员-专职-未转
					somPartyRec.setMemFulltimeNoNum(new BigDecimal(sheet.getCell(45, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(46, i).getContents().trim())){  //工作人员-兼职
					somPartyRec.setMemParttimeNum(new BigDecimal(sheet.getCell(46, i).getContents().trim()));
				}
				//********************组织关系 47、48、49、50、51、52*********************************
				if(!"".equals(sheet.getCell(47, i).getContents().trim())){  //在社会组织的党员数
					somPartyRec.setMemberSomNum(new BigDecimal(sheet.getCell(47, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(48, i).getContents().trim())){  //在业务主管单位的党员数
					somPartyRec.setMemberBusinessNum(new BigDecimal(sheet.getCell(48, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(49, i).getContents().trim())){  //在挂靠单位的党员数
					somPartyRec.setMemberAttachedNum(new BigDecimal(sheet.getCell(49, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(50, i).getContents().trim())){  //在属地党组织的党员数
					somPartyRec.setMemberPosssessionNum(new BigDecimal(sheet.getCell(50, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(51, i).getContents().trim())){  //在原工作单位的党员数
					somPartyRec.setMemberOrganNum(new BigDecimal(sheet.getCell(51, i).getContents().trim()));
				}
				if(!"".equals(sheet.getCell(52, i).getContents().trim())){  //在其他单位的党员数
					somPartyRec.setMemberOtherNum(new BigDecimal(sheet.getCell(52, i).getContents().trim()));
				}
				//********************发展党员 53、54、55*********************************
				if(!"".equals(sheet.getCell(53, i).getContents().trim())){  
					somPartyRec.setAppPartyNum(new BigDecimal(sheet.getCell(53, i).getContents().trim()));//申请入党人数
				}
				if(!"".equals(sheet.getCell(54, i).getContents().trim())){
					somPartyRec.setEnergeticNum(new BigDecimal(sheet.getCell(54, i).getContents().trim()));//入党积极分子人数
				}
				if(!"".equals(sheet.getCell(55, i).getContents().trim())){
					somPartyRec.setDevelopNum(new BigDecimal(sheet.getCell(55, i).getContents().trim()));//发展对象人数
				}
				//********************群团组织组建情况	 56、57、58、59*********************************
				//群团组织组建情况
				Cell groupTypeCellGH = sheet.getCell(56, i);//群团组织组建情况-工会-共青团-妇联-其他
				Cell groupTypeCellGQT = sheet.getCell(57, i);//群团组织组建情况-工会-共青团-妇联-其他
				Cell groupTypeCellFL = sheet.getCell(58, i);//群团组织组建情况-工会-共青团-妇联-其他
				Cell groupTypeCellQT = sheet.getCell(59, i);//群团组织组建情况-工会-共青团-妇联-其他
				
				if(!"".equals(groupTypeCellGH.getContents().trim())) {
					somPartyRec.setGroupType("0,");
				}
				if(!"".equals(groupTypeCellGQT.getContents().trim())) {
					somPartyRec.setGroupType("1,");
				}
				if(!"".equals(groupTypeCellFL.getContents().trim())) {
					somPartyRec.setGroupType("2,");
				}
				if(!"".equals(groupTypeCellQT.getContents().trim())) {
					somPartyRec.setGroupType("3,");
				}
				somPartyRec.setPartyStatus("0");//登记党建情况-默认赋值为 0：已登记
				somPartyRec.setPartyId(IdHelp.getUUID32());
				somPartyRec.setSorgId("1");
				somPartyRec.setMorgName(BspUtil.getCorpOrgan().getOrganName());
				somPartyRec.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
				somPartyRec.setCreateTime(DateUtil.getDay());
				if(isNullRow){
					//是空数据行
				}else{
					partyHisList.add(somPartyRec);//将党建历史信息添加到List
					sucCount++;
				}
			}
		}
			try{
				//执行保存
				partyDao.batchInsert(partyHisList);//保存党建历史信息List
				this.setReturn("sucCount", sucCount);//成功导入条数
				this.setReturn("sumCount", sumCount);//总记录条数
				this.setReturn("existCount", existCount);//已经存在于数据库中的记录条数
				this.setReturn("errorList", errorList.toString());
			}catch(Exception e) {
				e.printStackTrace();
				throw new BusinessException("导入失败，可能是数据库错误！");
			}
			
		} catch (BiffException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}