package com.inspur.sdmz.jtxx.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.loushang.bsp.id.util.MaxValueUtil;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.persistent.transaction.PlatformTransactionManager;
import org.loushang.persistent.transaction.TransactionDefinition;
import org.loushang.persistent.transaction.TransactionStatus;
import org.loushang.persistent.transaction.support.DefaultTransactionDefinition;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.TransactionFactory;

import com.inspur.cams.comm.extuser.util.ExtBspInfo;
import com.inspur.sdmz.comFamilyOrgan.dao.ComFamilyOrgan;
import com.inspur.sdmz.comFamilyOrgan.dao.ComFamilyOrganDao;
import com.inspur.sdmz.comm.util.BspUtil;
import com.inspur.sdmz.comm.util.DateUtil;
import com.inspur.sdmz.comm.util.PhotoUtil;
import com.inspur.sdmz.jtxx.dao.jdbc.YgjzJtxxCyxxDao;
import com.inspur.sdmz.jtxx.dao.jdbc.YgjzJtxxZrzhDao;
import com.inspur.sdmz.jtxx.dao.jdbc.YgjzJzzsDao;
import com.inspur.sdmz.jtxx.data.BaseinfoFamily;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;
import com.inspur.sdmz.jtxx.data.SamFamilyAssistance;
import com.inspur.sdmz.jtxx.data.SamFamilyCalamity;
import com.inspur.sdmz.jtxx.data.SamIndex;
import com.inspur.sdmz.jtxx.data.SamPeopleAccident;
import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.jtxx.data.SamPeopleDisease;
import com.inspur.sdmz.jtxx.data.SamPeopleEdu;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxCyxxDomain;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxDomain;
import com.inspur.sdmz.jtxx.dao.jdbc.SamFamilyHouseDao;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;
import com.inspur.sdmz.comm.util.IdHelp;
/**
 * @title:YgjzJtxxSaveCommand
 * @description:
 * @since:2011-04-18
 * @version:1.0
 */
public class YgjzJtxxCommand extends BaseAjaxCommand {
	IYgjzJtxxDomain service = ScaComponentFactory.getService( IYgjzJtxxDomain.class, "YgjzJtxxDomain/YgjzJtxxDomain");
	IYgjzJtxxCyxxDomain cyxxService = ScaComponentFactory.getService( IYgjzJtxxCyxxDomain.class, "YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
	
	//新增房屋基本信息
	private SamFamilyHouseDao samFamilyHouseDao = (SamFamilyHouseDao) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.SamFamilyHouseDao");
	
	/**
	 * 添加家庭信息和户主基本信息 
	 * 
	 */
	public void save() {
		//根据数据源获取事物管理器 
		PlatformTransactionManager txManager=TransactionFactory.getTransactionManager("dataSource");
		TransactionDefinition definition=new DefaultTransactionDefinition();
		TransactionStatus status=txManager.getTransaction(definition);
		HttpServletRequest request=(HttpServletRequest)getRequest();
		
		try{
		// 获取服务调用查询方法
		String opType = (String) getParameter("opType");
		if(opType == null){
			opType = "accept";
		}
		BaseinfoFamily ygjzjtxx = getYgjzJtxx(opType);//家庭基本信息
		if(ygjzjtxx.getAgreement()!=null){//委托协议
			ygjzjtxx.setAgreementName(ygjzjtxx.getAgreement().getFileName());
		}
		String nowTime = DateUtil.getNewTime();
		String familyId = ygjzjtxx.getFamilyId();//家庭ID
		String areaCode=ygjzjtxx.getRegOrgArea();
		String employeeName=ygjzjtxx.getRegPeople();

		List<SamFamilyCalamity> YgjzJtxxZrzhList = getYgjzJtxxZrzhList();// 家庭信息-灾害种类
		service.saveYgjzJtxxZrzh(YgjzJtxxZrzhList);

		List<BaseinfoFamily> ygjzjtxxList = new ArrayList<BaseinfoFamily>();//家庭信息

		dealPhoto(ygjzjtxx, nowTime, areaCode, employeeName);//处理家庭照片
		
		ygjzjtxxList.add(ygjzjtxx);
		if("update".equals(opType) ||ygjzjtxx.getAgreement()!=null){//修改页面上传委托协议书
			if(ygjzjtxx.getAgreement()!=null){
				ygjzjtxx.setAgreementName(ygjzjtxx.getAgreement().getFileName());
			}
			service.updateYgjzJtxx(ygjzjtxxList);
		}  else {
			service.saveYgjzJtxx(ygjzjtxxList);
			if("accept".equals(opType)){
			 ComFamilyOrgan comFamilyOrgan = new ComFamilyOrgan();
			 comFamilyOrgan.setFamilyId(ygjzjtxx.getFamilyId());
			 comFamilyOrgan.setOrganId(ygjzjtxx.getRegOrg());
			 comFamilyOrgan.setOrganName(ygjzjtxx.getRegOrgName());
			 String organType="";
			 try {
				organType= ExtBspInfo.getUserInfo(request).getOrganType();
			} catch (Exception e) {
				
			}finally{
			  if(StringUtils.isNotEmpty(organType)){
			    comFamilyOrgan.setOrganType(organType);
					}
			  if("accept".equals(opType)){
				  service.FamilyInsert(comFamilyOrgan);
			  }else{
				  service.FamilyUpdate(comFamilyOrgan);
			  }
			}
			}
		
		}
		
		//救助类型
		Record[] SamFamilyAssistanceList =(Record[])getParameter("assistanceTypeList");
		if(SamFamilyAssistanceList!=null){
			List<SamFamilyAssistance> SamFamilyAssistanceList2 =new ArrayList<SamFamilyAssistance>();
			for(int i=0;i<SamFamilyAssistanceList.length;i++){
				SamFamilyAssistance bean=(SamFamilyAssistance)SamFamilyAssistanceList[i].toBean(SamFamilyAssistance.class);
				SamFamilyAssistanceList2.add(bean);
			}
			//判断，如果opType＝update,说明是从变更页面提交保存按钮过来的，执行两个参数的方法；反之是从登记页面保存过来的，执行一个参数的方法。
				if("update".equals(opType)){
					service.saveSamFamilyAssistance(SamFamilyAssistanceList2,familyId);
				}else if("change".equals(opType)){
					service.saveSamFamilyAssistance(SamFamilyAssistanceList2,familyId);
				}else{
					service.saveSamFamilyAssistance(SamFamilyAssistanceList2);
				}
		}else{
		}
		//新增房屋信息 基于程序原因做如下处理，将原有家庭的房屋信息存储从表。  20111107    修改开始
		SamFamilyHouse samFamilyHouse = new SamFamilyHouse();
		 if(opType.equals("accept")){
			 samFamilyHouse.setHouseId(IdHelp.getUUID32());
			 samFamilyHouse.setFamilyId(ygjzjtxx.getFamilyId());
			 samFamilyHouse.setHouseQuality(ygjzjtxx.getHouseQuality());//住房类型
			 samFamilyHouse.setHouseStructure(ygjzjtxx.getBuildingStructure());//住房结构
			 samFamilyHouse.setHouseStatus(ygjzjtxx.getHouseStatus());//房屋状况
			 samFamilyHouse.setBuildArea(ygjzjtxx.getBuildArea());//建筑面积
			 //samFamilyHouseDao.insert(samFamilyHouse);
			 service.HouseInsert(samFamilyHouse);
		 }else if(opType.equals("update")){
			 Map map= new HashMap();
		     map.put("FAMILY_ID", ygjzjtxx.getFamilyId());
			 List samFamilyHouseList= samFamilyHouseDao.queryNoPage(map);
			 if(samFamilyHouseList.size()>0){
				 samFamilyHouse= (SamFamilyHouse) samFamilyHouseList.get(0);
				 samFamilyHouse.setHouseQuality(ygjzjtxx.getHouseQuality());//住房类型
				 samFamilyHouse.setHouseStructure(ygjzjtxx.getBuildingStructure());//住房结构
				 samFamilyHouse.setHouseStatus(ygjzjtxx.getHouseStatus());//房屋状况
				 samFamilyHouse.setBuildArea(ygjzjtxx.getBuildArea());//建筑面积
				 service.HouseUpdate(samFamilyHouse);
			 }else if(samFamilyHouseList.size()==0){
				 samFamilyHouse.setHouseId(IdHelp.getUUID32());
				 samFamilyHouse.setFamilyId(ygjzjtxx.getFamilyId());
				 samFamilyHouse.setHouseQuality(ygjzjtxx.getHouseQuality());//住房类型
				 samFamilyHouse.setHouseStructure(ygjzjtxx.getBuildingStructure());//住房结构
				 samFamilyHouse.setHouseStatus(ygjzjtxx.getHouseStatus());//房屋状况
				 samFamilyHouse.setBuildArea(ygjzjtxx.getBuildArea());//建筑面积
				 service.HouseInsert(samFamilyHouse);
			 }
		 }
		//新增房屋信息 基于程序原因做如下处理，将原有家庭的房屋信息存储从表。  20111107    修改结束
		if(opType =="accept"){
		List YgjzCyxxJyxxList = getYgjzCyxxJyxxList();//教育信息
		cyxxService.saveYgjzCyxxJyxx(YgjzCyxxJyxxList);

		List YgjzCyxxCjxxList = getYgjzCyxxCjxxList();//残疾信息
		cyxxService.saveYgjzCyxxCjxx(YgjzCyxxCjxxList);

		List YgjzCyxxHbxxList = getYgjzCyxxHbxxList();//患病信息
		cyxxService.saveYgjzCyxxHbxx(YgjzCyxxHbxxList);

		List YgjzCyxxSgxxList = getYgjzCyxxSgxxList();//事故信息
		cyxxService.saveYgjzCyxxSgxx(YgjzCyxxSgxxList);

		BaseinfoPeople ygjzjtxxcyxx = getYgjzJtxxCyxx(opType);//成员信息
		//存取家庭成员照片
		dealPhotoC(ygjzjtxxcyxx, nowTime, areaCode, employeeName);//处理照片

		List ygjzjtxxCyxxList = new ArrayList();
		ygjzjtxxCyxxList.add(ygjzjtxxcyxx);
		cyxxService.saveYgjzJtxxCyxx(ygjzjtxxCyxxList);
		//更新家庭信息
		service.updatePeopleNum(familyId);
		// 计算救助指数
        service.countJtxxJzzs(familyId);
		}
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		txManager.commit(status);
	}
	/**
	 * 审核提交
	 * 
	 */
	public void exam() {
		// 获取服务调用查询方法
		BaseinfoFamily ygjzjtxx = getYgjzJtxx("exam");
		List<BaseinfoFamily> ygjzjtxxList = new ArrayList<BaseinfoFamily>();
		ygjzjtxxList.add(ygjzjtxx);

		service.saveYgjzJtxx(ygjzjtxxList);
	}

	/**
	 * 更正提交
	 */
	public void correct() {
		// 获取服务调用查询方法
		BaseinfoFamily ygjzjtxx = getYgjzJtxx("correct");
		String familyId = ygjzjtxx.getFamilyId();//家庭ID
		String nowTime = DateUtil.getNewTime();
		String areaCode=ygjzjtxx.getRegOrgArea();//登记单位
		String employeeName=ygjzjtxx.getRegPeople();

		dealPhoto(ygjzjtxx, nowTime, areaCode, employeeName);//处理家庭照片

		Record[] SamFamilyAssistanceList =(Record[])getParameter("assistanceTypeList");
		if(SamFamilyAssistanceList!=null){
			List<SamFamilyAssistance> SamFamilyAssistanceList2 =new ArrayList<SamFamilyAssistance>();
			for(int i=0;i<SamFamilyAssistanceList.length;i++){
				SamFamilyAssistance bean=(SamFamilyAssistance)SamFamilyAssistanceList[i].toBean(SamFamilyAssistance.class);
				SamFamilyAssistanceList2.add(bean);
			}
			service.saveSamFamilyAssistance(SamFamilyAssistanceList2,familyId);
		}
		List<SamFamilyCalamity> YgjzJtxxZrzhList = getYgjzJtxxZrzhList();// 家庭信息-灾害种类
		service.saveYgjzJtxxZrzh(YgjzJtxxZrzhList);
		List<SamIndex> YgjzJzzsList = getYgjzJzzsList();// 家庭信息-救助指数
		service.saveYgjzJzzs(YgjzJzzsList);

		List<BaseinfoFamily> ygjzjtxxList = new ArrayList<BaseinfoFamily>();
		ygjzjtxxList.add(ygjzjtxx);

		service.saveYgjzJtxx(ygjzjtxxList);
	}
	/**
	 *
	 * 移交到审核
	 */
	public void toExam() {
		// 获取服务调用查询方法
		//当前登陆人单位区划
		HttpServletRequest request=(HttpServletRequest)getRequest();
		//ParameterSet pset = getParameterSet();
		//String organType=(String)getParameter("organType");
		//if(organType==null){
		//	organType="";
		//}
		String organType="";
		String organCode="";
		try{
			organType= ExtBspInfo.getUserInfo(request).getOrganType();
		}catch(Exception e){
			organType="";
		}
		if("".equals(organType)){
			 organCode=BspUtil.getCorpOrgan().getOrganCode();//当前登录行政区划
		}else{
			 organCode = ExtBspInfo.getUserInfo(request).getAreaCode();
		}
		String[] jtids = (String[]) getParameter("jtids");
		String jtidStr = "";
		for (int i = 0; i < jtids.length; i++) {
			if (jtidStr.length() > 0)
				jtidStr += ",";
			jtidStr += jtids[i];
		}
		 String createOrgan="";
		 if(organCode.substring(2,12).equals("0000000000")){
				createOrgan=organCode;
			}else if(organCode.substring(4,12).equals("00000000")){
				createOrgan=organCode;
			}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
				createOrgan=organCode;
			}else if(organCode.substring(9,12).equals("000")){
				createOrgan=organCode.substring(0,6)+"000000";
			}else  {
				createOrgan=organCode.substring(0,6)+"000000";
		 }
		service.updateCurrentActivity("EXAM", jtidStr,createOrgan);
	}
	/**
	 *
	 * 更新救助指数
	 */
	public void updateJzzs() {
		// 获取服务调用查询方法
		//当前登陆人单位区划

		String[] jtids = (String[]) getParameter("jtids");
		for (int i = 0; i < jtids.length; i++) {
				service.countJtxxJzzs( jtids[i]);
			//	service.updateJtdz( jtids[i]);//JTDZ: 1
		}

	}
	/**
	 * @author 信息注销
	 */
	public void delete() {
			//根据数据源获取事物管理器
			PlatformTransactionManager txManager=TransactionFactory.getTransactionManager("dataSource");
			//定义事务的一些属性，比如只读，隔离级别等
			TransactionDefinition definition=new DefaultTransactionDefinition();
			//事务开始
			TransactionStatus status=txManager.getTransaction(definition);
			try{
			String[] delId = (String[]) getParameter("delIds");
			List<String> list = new ArrayList<String>();
			for (int i = 0; i < delId.length; i++) {
				list.add(delId[i]);
			}
			// 家庭成员
			YgjzJtxxCyxxDao ygjzjtxxcyxxDao = null;
			try {
				ygjzjtxxcyxxDao = new YgjzJtxxCyxxDao();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(delId!=null||!delId.equals("")){
			ygjzjtxxcyxxDao.batchDeleteByYgjzJtxx(delId);
			// 受助类型
			service.bathchDeleteByFamilyId(delId);
			// 灾害种类
			}
			YgjzJtxxZrzhDao ygjzjtxxzrzhDao = null;
			try {
				ygjzjtxxzrzhDao = new YgjzJtxxZrzhDao();
			} catch (Exception e) {
				e.printStackTrace();
			}
			ygjzjtxxzrzhDao.batchDeleteByYgjzJtxx(delId);
			// 救灾指数
			YgjzJzzsDao ygjzjzzsDao = null;
			try {
				ygjzjzzsDao = new YgjzJzzsDao();
				ygjzjzzsDao.batchDeleteByYgjzJtxx(delId);
			 } catch (Exception e) {
			  	e.printStackTrace();
			}
			 service.delete(list);
			}catch(Throwable err){
				//事务回退
				txManager.rollback(status);
				throw new RuntimeException(err);
			}
			txManager.commit(status);
		}

	/**
	 * 家庭信息获取
	 *
	 * @return
	 */
	private BaseinfoFamily getYgjzJtxx(String opType) {
		Record ygjzjtxxRecord = (Record) getParameter("YgjzJtxxRecord");
		
		BaseinfoFamily bean = (BaseinfoFamily) ygjzjtxxRecord.toBean(BaseinfoFamily.class);
		HttpServletRequest request=(HttpServletRequest)getRequest();
		String organType="";
		try{
			organType= ExtBspInfo.getUserInfo(request).getOrganType();
		}catch(Exception e){
			organType="";
		}
		if(organType==null){
			
			organType="";
		}
		if ("accept".equals(opType)) {//添加操作
			if("".equals(organType)){
				bean.setRegId(BspUtil.getEmpOrganId());//登记人ID
				bean.setDomicileCode(BspUtil.getCorpOrgan().getOrganCode());//属地行政区划
				bean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());//登记人姓名		
				bean.setRegOrg(BspUtil.getCorpOrganId());//登记单位ID
				bean.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());//登记单位名称
				bean.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
				String Code=BspUtil.getCorpOrgan().getOrganCode().substring(0,6)+"000000";
				bean.setApanageCode(Code);
				bean.setDomicileCode(Code);
			}else{
				bean.setRegId(ExtBspInfo.getUserInfo(request).getUserId());//登记人ID
				bean.setDomicileCode(ExtBspInfo.getUserInfo(request).getAreaCode());//属地行政区划
				bean.setRegPeople(ExtBspInfo.getUserInfo(request).getUserName());//登记人姓名		
				bean.setRegOrg(ExtBspInfo.getUserInfo(request).getOrganId());//登记单位ID
				bean.setRegOrgName(ExtBspInfo.getUserInfo(request).getOrganName());//登记单位名称
				bean.setRegOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
				String Code=ExtBspInfo.getUserInfo(request).getAreaCode().substring(0,6)+"000000";
				bean.setApanageCode(Code);
				bean.setDomicileCode(Code);
			}
			
			bean.setRegTime(DateUtil.getNewTime());//登记时间
		}else if ("update".equals(opType)) {//变更做作
			bean.setCurActivity("ACCEPT");
			bean.setCheckFlag("1");
			if("".equals(organType)){
				bean.setModId(BspUtil.getEmpOrganId());
				bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
				bean.setModOrg(BspUtil.getCorpOrganId());
				bean.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
				bean.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
				String Code=BspUtil.getCorpOrgan().getOrganCode().substring(0,6)+"000000";
				bean.setApanageCode(Code);
				bean.setDomicileCode(Code);
			}else{
				bean.setModId(ExtBspInfo.getUserInfo(request).getUserId());
				bean.setModPeople(ExtBspInfo.getUserInfo(request).getUserName());
				bean.setModOrg(ExtBspInfo.getUserInfo(request).getOrganId());
				bean.setModOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
				bean.setModOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
				String Code=ExtBspInfo.getUserInfo(request).getAreaCode().substring(0,6)+"000000";
				bean.setApanageCode(Code);
				bean.setDomicileCode(Code);
			}			
			bean.setModTime(DateUtil.getNewTime());
		}else if ("change".equals(opType)) {//查询页面变更操作
			if("".equals(organType)){
				bean.setModId(BspUtil.getEmpOrganId());
				bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
				bean.setModOrg(BspUtil.getCorpOrganId());
				bean.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
				bean.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
				String Code=BspUtil.getCorpOrgan().getOrganCode().substring(0,6)+"000000";
				bean.setApanageCode(Code);
				bean.setDomicileCode(Code);
			}else{
				bean.setModId(ExtBspInfo.getUserInfo(request).getUserId());
				bean.setModPeople(ExtBspInfo.getUserInfo(request).getUserName());
				bean.setModOrg(ExtBspInfo.getUserInfo(request).getOrganId());
				bean.setModOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
				bean.setModOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
				String Code=ExtBspInfo.getUserInfo(request).getAreaCode().substring(0,6)+"000000";
				bean.setApanageCode(Code);
				bean.setDomicileCode(Code);
			}
			
			bean.setModTime(DateUtil.getNewTime());
		}else if ("correct".equals(opType)) {//更正操作	
			bean.setCurActivity("ACCEPT");
			bean.setCheckFlag("1");
			if("".equals(organType)){
				bean.setModId(BspUtil.getEmpOrganId());
				bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
				bean.setModOrg(BspUtil.getCorpOrganId());
				bean.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
				String Code=BspUtil.getCorpOrgan().getOrganCode().substring(0,6)+"000000";
				bean.setApanageCode(Code);
				bean.setDomicileCode(Code);
				bean.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			}else{
				bean.setModId(ExtBspInfo.getUserInfo(request).getUserId());
				bean.setModPeople(ExtBspInfo.getUserInfo(request).getUserName());
				bean.setModOrg(ExtBspInfo.getUserInfo(request).getOrganId());
				bean.setModOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
				bean.setModOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
				String Code=ExtBspInfo.getUserInfo(request).getAreaCode().substring(0,6)+"000000";
				bean.setApanageCode(Code);
				bean.setDomicileCode(Code);
			}
			bean.setModTime(DateUtil.getNewTime());
		} else if ("exam".equals(opType)) {//审核操作
			String shbz=bean.getCheckFlag();
			if(shbz.equals("0")){
				bean.setCurActivity("CORRECT");//转更正
			 }else
			if(shbz.equals("3")){
			bean.setCurActivity("FINISHOK");//审核完结通过
			}else  if(shbz.equals("2")){
			bean.setCurActivity("FINISHNO");//审核完结未通过
			}else if(shbz.equals("1")) {
			bean.setCurActivity("EXAM");//不做操作
			}
			if("".equals(organType)){
				bean.setCheckId(BspUtil.getEmpOrganId());
				bean.setCheckPeople(BspUtil.getEmpOrgan().getOrganName());
				bean.setCheckOrg(BspUtil.getCorpOrganId());
				bean.setCheckOrgName(BspUtil.getCorpOrgan().getOrganName());
				bean.setCheckOrgArea(BspUtil.getCorpOrgan().getOrganCode());
				bean.setCheckTime(DateUtil.getNewTime());
			}else{
				bean.setCheckId(ExtBspInfo.getUserInfo(request).getUserId());
				bean.setCheckPeople(ExtBspInfo.getUserInfo(request).getUserName());
				bean.setCheckOrg(ExtBspInfo.getUserInfo(request).getOrganId());
				bean.setCheckOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
				bean.setCheckOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
				bean.setCheckTime(DateUtil.getNewTime());
			}
			
		}
		return bean;
	}

	/**
	 * 家庭成员信息获取
	 *
	 * @return
	 */
	private List<BaseinfoPeople> getYgjzJtxxCyxxList() {
		Record[] ygjzjtxxcyxxRecords = (Record[]) getParameter("YgjzJtxxCyxxRecords");
		if (ygjzjtxxcyxxRecords == null || ygjzjtxxcyxxRecords.length == 0) {
			return null;
		}
		List<BaseinfoPeople> list = new ArrayList<BaseinfoPeople>();
		for (int i = 0; i < ygjzjtxxcyxxRecords.length; i++) {
			BaseinfoPeople ygjzjtxxcyxx = (BaseinfoPeople) ygjzjtxxcyxxRecords[i].toBean(BaseinfoPeople.class);

			list.add(ygjzjtxxcyxx);
		}
		return list;
	}

	/**
	 * 家庭成员残疾信息
	 *
	 * @return
	 */
	private List<SamPeopleDisability> getYgjzCyxxCjxxList() {
		Record[] ygjzcyxxcjxxRecords = (Record[]) getParameter("YgjzCyxxCjxxRecords");
		if (ygjzcyxxcjxxRecords == null || ygjzcyxxcjxxRecords.length == 0) {
			return null;
		}
		List<SamPeopleDisability> list = new ArrayList<SamPeopleDisability>();
		for (int i = 0; i < ygjzcyxxcjxxRecords.length; i++) {
			SamPeopleDisability ygjzcyxxcjxx = (SamPeopleDisability) ygjzcyxxcjxxRecords[i]
					.toBean(SamPeopleDisability.class);
			list.add(ygjzcyxxcjxx);
		}
		return list;
	}

	/**
	 * 家庭成员教育信息
	 *
	 * @return
	 */
	private List<SamPeopleEdu> getYgjzCyxxJyxxList() {
		Record[] ygjzcyxxjyxxRecords = (Record[]) getParameter("YgjzCyxxJyxxRecords");
		if (ygjzcyxxjyxxRecords == null || ygjzcyxxjyxxRecords.length == 0) {
			return null;
		}
		List<SamPeopleEdu> list = new ArrayList<SamPeopleEdu>();
		for (int i = 0; i < ygjzcyxxjyxxRecords.length; i++) {
			SamPeopleEdu ygjzcyxxjyxx = (SamPeopleEdu) ygjzcyxxjyxxRecords[i]
					.toBean(SamPeopleEdu.class);
			list.add(ygjzcyxxjyxx);
		}
		return list;
	}

	/**
	 * 家庭成员患病信息
	 *
	 * @return
	 */
	private List<SamPeopleDisease> getYgjzCyxxHbxxList() {
		Record[] ygjzcyxxhbxxRecords = (Record[]) getParameter("YgjzCyxxHbxxRecords");
		if (ygjzcyxxhbxxRecords == null || ygjzcyxxhbxxRecords.length == 0) {
			return null;
		}
		List<SamPeopleDisease> list = new ArrayList<SamPeopleDisease>();
		for (int i = 0; i < ygjzcyxxhbxxRecords.length; i++) {
			SamPeopleDisease ygjzcyxxhbxx = (SamPeopleDisease) ygjzcyxxhbxxRecords[i]
					.toBean(SamPeopleDisease.class);
			list.add(ygjzcyxxhbxx);
		}
		return list;
	}

	/**
	 * 家庭成员事故信息
	 *
	 * @return
	 */
	private List<SamPeopleAccident> getYgjzCyxxSgxxList() {
		Record[] ygjzcyxxsgxxRecords = (Record[]) getParameter("YgjzCyxxSgxxRecords");
		if (ygjzcyxxsgxxRecords == null || ygjzcyxxsgxxRecords.length == 0) {
			return null;
		}
		List<SamPeopleAccident> list = new ArrayList<SamPeopleAccident>();
		for (int i = 0; i < ygjzcyxxsgxxRecords.length; i++) {
			SamPeopleAccident ygjzcyxxhbxx = (SamPeopleAccident) ygjzcyxxsgxxRecords[i]
					.toBean(SamPeopleAccident.class);
			list.add(ygjzcyxxhbxx);
		}
		return list;
	}

	/**
	 * 家庭信息-受助类型
	 *
	 * @return
	 */
	private List<SamFamilyAssistance> getYgjzJtxxSzlxList() {
		Record ygjzjtxxRecord = (Record) getParameter("assistanceTypeList");
		BaseinfoFamily bean = (BaseinfoFamily) ygjzjtxxRecord.toBean(BaseinfoFamily.class);
		String jzlx=bean.getAssistanceType();
		String [] jzlxDm=jzlx.split(",");

		List<SamFamilyAssistance> list = new ArrayList<SamFamilyAssistance>();


		for(int i=0;i<jzlxDm.length;i++){
			SamFamilyAssistance ygjzjtxxszlx = new SamFamilyAssistance();
			ygjzjtxxszlx.setFamilyId(bean.getFamilyId());
			ygjzjtxxszlx.setAssistanceType(jzlxDm[i]);
			ygjzjtxxszlx.setState(Record.STATE_NEW);
			list.add(ygjzjtxxszlx);
		}

		return list;
	}

	/**
	 * 家庭信息--灾害种类
	 *
	 * @return
	 */
	private List<SamFamilyCalamity> getYgjzJtxxZrzhList() {
		Record[] ygjzjtxxzrzhRecords = (Record[]) getParameter("YgjzJtxxZrzhRecords");
		if (ygjzjtxxzrzhRecords == null || ygjzjtxxzrzhRecords.length == 0) {
			return null;
		}
		List<SamFamilyCalamity> list = new ArrayList<SamFamilyCalamity>();
		for (int i = 0; i < ygjzjtxxzrzhRecords.length; i++) {
			SamFamilyCalamity ygjzjtxxzrzh = (SamFamilyCalamity) ygjzjtxxzrzhRecords[i]
					.toBean(SamFamilyCalamity.class);
			list.add(ygjzjtxxzrzh);
		}

		return list;
	}

	/**
	 * 家庭信息--救助指数
	 *
	 * @return
	 */
	private List<SamIndex> getYgjzJzzsList() {
		Record[] ygjzjzzsRecords = (Record[]) getParameter("YgjzJzzsRecords");
		if (ygjzjzzsRecords == null || ygjzjzzsRecords.length == 0) {
			return null;
		}
		List<SamIndex> list = new ArrayList<SamIndex>();
		for (int i = 0; i < ygjzjzzsRecords.length; i++) {
			SamIndex ygjzjzzs = (SamIndex) ygjzjzzsRecords[i]
					.toBean(SamIndex.class);
			list.add(ygjzjzzs);
		}

		return list;
	}
	/**
	 * 获取生成身份证号码
	 *
	 */
	public void getMaxCode(){
		HttpServletRequest request=(HttpServletRequest)getRequest();
		String organType="";
		String organCode="";
			try{
				organType=ExtBspInfo.getUserInfo(request).getOrganType();
			
			}catch (Exception e) {
				 organCode=BspUtil.getCorpOrgan().getOrganCode();//当前登录行政区划
			}
			if(StringUtils.isNotEmpty(organType)){
				 organCode = ExtBspInfo.getUserInfo(request).getAreaCode();
			}
		
		String idcardCode = MaxValueUtil.nextStringValue("IDCard_CODE");
		String idCardExtend="B"+organCode+idcardCode;
		setReturn("idCardExtend", idCardExtend);
	}
	/**
	 * 获取生成身份证号码
	 *
	 */
	public void setPhotoInfo(){
		HttpServletRequest request=(HttpServletRequest)getRequest();
		ParameterSet pset = getParameterSet();
		String organType=(String)pset.getParameter("organType");
		String organCode="";
		if(!StringUtils.isNotEmpty(organType)){
			 organCode=BspUtil.getCorpOrgan().getOrganCode();//当前登录行政区划
		}else{
			 organCode = ExtBspInfo.getUserInfo(request).getAreaCode();
		}
		String idcardCode = MaxValueUtil.nextStringValue("IDCard_CODE");
		String idCardExtend="B"+organCode+idcardCode;
		setReturn("idCardExtend", idCardExtend);
	}

	/**
	 * 家庭成员信息获取
	 *
	 * @return
	 */

	private BaseinfoPeople getYgjzJtxxCyxx(String opType) {
		Record ygjzjtxxcyxxRecord = (Record) getParameter("YgjzJtxxCyxxRecord");
		BaseinfoPeople bean = (BaseinfoPeople) ygjzjtxxcyxxRecord.toBean(BaseinfoPeople.class);
		HttpServletRequest request=(HttpServletRequest)getRequest();
		ParameterSet pset = getParameterSet();
		String organType=(String)pset.getParameter("organType");
		if(organType==null){
			organType="";
		}
		if ("accept".equals(opType)) {
			if("".equals(organType)){
				bean.setRegId(BspUtil.getEmpOrganId());
				bean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
				bean.setRegOrg(BspUtil.getCorpOrganId());
				bean.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
				bean.setRegOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			}else{
				bean.setRegId(ExtBspInfo.getUserInfo(request).getUserId());//登记人ID
				bean.setRegPeople(ExtBspInfo.getUserInfo(request).getUserName());//登记人姓名		
				bean.setRegOrg(ExtBspInfo.getUserInfo(request).getOrganId());//登记单位ID
				bean.setRegOrgName(ExtBspInfo.getUserInfo(request).getOrganName());//登记单位名称
				bean.setRegOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
			}
			
			bean.setRegTime(DateUtil.getNewTime());
		} else if ("correct".equals(opType)) {
			if("".equals(organType)){
				bean.setModId(BspUtil.getEmpOrganId());
				bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
				bean.setModOrg(BspUtil.getCorpOrganId());
				bean.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
				bean.setModOrgArea(BspUtil.getCorpOrgan().getOrganCode());
			}else{
				bean.setModId(ExtBspInfo.getUserInfo(request).getUserId());
				bean.setModPeople(ExtBspInfo.getUserInfo(request).getUserName());
				bean.setModOrg(ExtBspInfo.getUserInfo(request).getOrganId());
				bean.setModOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
				bean.setModOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
			}
			bean.setModTime(DateUtil.getNewTime());
		} else if ("exam".equals(opType)) {
			if("".equals(organType)){
				bean.setCheckId(BspUtil.getEmpOrganId());
				bean.setCheckPeople(BspUtil.getEmpOrgan().getOrganName());
				bean.setCheckOrg(BspUtil.getCorpOrganId());
				bean.setCheckOrgName(BspUtil.getCorpOrgan().getOrganName());
				bean.setCheckOrgArea(BspUtil.getCorpOrgan().getOrganCode());
				
			}else{
				bean.setCheckId(ExtBspInfo.getUserInfo(request).getUserId());
				bean.setCheckPeople(ExtBspInfo.getUserInfo(request).getUserName());
				bean.setCheckOrg(ExtBspInfo.getUserInfo(request).getOrganId());
				bean.setCheckOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
				bean.setCheckOrgArea(ExtBspInfo.getUserInfo(request).getAreaCode());
			}
			bean.setCheckTime(DateUtil.getNewTime());
		}

		return bean;
	}
	/**
	 * 照片处理(申请人证件照片、申请人现场照片)
	 * @param icmApplyInfo
	 */
	public void dealPhoto(BaseinfoFamily ygjzjtxx,String nowTime,String areaCode,String employeeName) {
		// 采集证件照片
		String applybase64Code = "";
		String applyId = "";
		applybase64Code = ygjzjtxx.getPhotoTemp();
		if (null != applybase64Code && !"".equals(applybase64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			applyId = PhotoUtil.getCrjPhotoId(applybase64Code, "1", "JPG",
					"11", ygjzjtxx.getFamilyId(), nowTime, areaCode, employeeName);
		}

		if (applyId != null && !"".equals(applyId)) {
			ygjzjtxx.setPhotoId(applyId);
		}

	}
	/**家庭成员
	 * 照片处理(申请人证件照片、申请人现场照片)
	 * @param icmApplyInfo
	 */
	public void dealPhotoC(BaseinfoPeople ygjzjtxxcyxx,String nowTime,String areaCode,String employeeName) {
		// 采集证件照片
		String applybase64Code = "";
		String applyId = "";
		applybase64Code = ygjzjtxxcyxx.getPeoplePhotoTemp();
		if (null != applybase64Code && !"".equals(applybase64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			applyId = PhotoUtil.getCrjPhotoId(applybase64Code, "1", "JPG",
					"11", ygjzjtxxcyxx.getFamilyId(), nowTime, areaCode, employeeName);
		}

		if (applyId != null && !"".equals(applyId)) {
			ygjzjtxxcyxx.setPhotoId(applyId);
		}

	}
}