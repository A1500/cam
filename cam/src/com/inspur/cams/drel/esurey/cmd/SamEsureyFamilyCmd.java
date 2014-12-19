package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.util.regex.Pattern;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.persistent.transaction.PlatformTransactionManager;
import org.loushang.persistent.transaction.TransactionDefinition;
import org.loushang.persistent.transaction.TransactionStatus;
import org.loushang.persistent.transaction.support.DefaultTransactionDefinition;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.TransactionFactory;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;


import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.jdbc.BaseinfoFamilyArchiveDao;
import com.inspur.cams.drel.esurey.dao.jdbc.SamEsureyFamilyDao;
import com.inspur.cams.drel.esurey.data.SamEsureyFamily;
import com.inspur.cams.drel.esurey.data.SamEsureyPeople;
import com.inspur.cams.drel.esurey.domain.ISamEsureyFamilyDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyPeopleDomain;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxCyxxDomain;

public class SamEsureyFamilyCmd extends BaseAjaxCommand{
	//困难家庭成员信息回填
	public  static final String BASE_FAMILY="baseFamily";
	//经济核对成员信息回填
	public static final String ESUREY_FAMILY="esureyFamily";
	// 户主关系---户主
	public static final String HOUSE_HOLD="01";
	private ISamEsureyFamilyDomain service = ScaComponentFactory.getService(ISamEsureyFamilyDomain.class, "SamEsureyFamilyDomain/SamEsureyFamilyDomain");
	private ISamEsureyPeopleDomain peopleService = ScaComponentFactory.getService(ISamEsureyPeopleDomain.class, "SamEsureyPeopleDomain/SamEsureyPeopleDomain");
	private IYgjzJtxxCyxxDomain  basePeopleService=ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
	private SamEsureyFamilyDao dao = (SamEsureyFamilyDao) DaoFactory
	.getDao("com.inspur.cams.drel.esurey.dao.jdbc.SamEsureyFamilyDao");
	
//	private BaseinfoFamilyArchiveDao baseinfoFamilyArchiveDao = (BaseinfoFamilyArchiveDao) DaoFactory
//	.getDao("com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.jdbc.BaseinfoFamilyArchiveDao");
	public void insert(){
		String signType = (String) getParameter("signType");
		String parentFamily=(String)getParameter("parentFamily");
		String isSupport=(String)getParameter("isSupport");
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			SamEsureyFamily  bean=getSamEsureyFamily(signType);
			SamEsureyPeople  peoplebean=getSamEsureyPeople(signType);
			String peopleId=peoplebean.getPeopleId();
			String familyId=peoplebean.getFamilyId();
			if("insert".equalsIgnoreCase(signType)){
				service.insert(bean);
				peopleService.insert(peoplebean);
				if(StringUtils.isNotEmpty(parentFamily)){
					fillBackFamilyMember(parentFamily,bean,isSupport);
				}
				service.updateFamilyInfo(familyId);
			}else if("update".equalsIgnoreCase(signType)){
				service.update(bean);
				peopleService.update(peoplebean);
				service.updateFamilyInfo(familyId);
			}		
			//社保信息
			Record[] SamSocials = (Record[]) getParameter("SocialBeans");
			if(SamSocials!=null&&SamSocials.length!=0){			
				service.getSamEsureySocial(SamSocials,peopleId);
				//社保财产信息
				service.getEstateSocial(peopleId,familyId);
			}
			
			//财产信息
			Record[] estateRecords = (Record[]) getParameter("estateRecords");
			if(estateRecords!=null&&estateRecords.length!=0){
				service.getSamEsureyEstate(estateRecords, peopleId,familyId);
			}
			//房屋信息
			Record[] houseRecords = (Record[]) getParameter("houseRecords");
			if(houseRecords!=null&&houseRecords.length!=0){
				service.getSamEsureyHouse(houseRecords, peopleId);
				//房屋财产信息
				service.getEsureyHouse(peopleId,familyId);
			}	
			//工商信息
			Record[] businessRecords = (Record[]) getParameter("businessRecords");
			if(businessRecords!=null&&businessRecords.length!=0){
				service.getSamEsureyBusiness(businessRecords, peopleId);
			}
			//车辆信息
			Record[] carRecords = (Record[]) getParameter("carRecords");
			if(carRecords!=null&&carRecords.length!=0){
				service.getSamEsureyCar(carRecords, peopleId);
				//车辆财产信息
				service.getEsureyCar(peopleId,familyId);
			}
			//国税
			Record[] taxRecords = (Record[]) getParameter("taxRecords");
			if(taxRecords!=null&&taxRecords.length!=0){
				service.getEsureyTaxG(taxRecords, peopleId);
			}
			//地税信息
			Record[] taxRecords2 = (Record[]) getParameter("taxRecords2");
			if(taxRecords2!=null&&taxRecords2.length!=0){
				service.getEsureyTaxD(taxRecords2, peopleId);
			}
			// 公积金信息
			Record[] fundRecords = (Record[]) getParameter("fundRecords");
			if(fundRecords!=null&&fundRecords.length!=0){
				service.getEsureyFund(fundRecords, peopleId);
			}
			// 人行信息
			Record[] bankRecords = (Record[]) getParameter("bankRecords");
			if(bankRecords!=null&&bankRecords.length!=0){
				service.getEsureyBank(bankRecords, peopleId);
				//人行财产信息
				service.getBankEstate(peopleId,familyId);
			}
			// 证监信息
			Record[] securitiesRecords = (Record[]) getParameter("securitiesRecords");
			if(securitiesRecords!=null&&securitiesRecords.length!=0){
				service.getEsureySecurities(securitiesRecords, peopleId);
				//有价证券
				service.getSecuritiesEstate(peopleId,familyId);
			}
			// 保监信息
			Record[] insuranceRecords = (Record[]) getParameter("insuranceRecords");
			if(insuranceRecords!=null&&insuranceRecords.length!=0){
				service.getEsureyInsurance(insuranceRecords, peopleId);
			}	
		}catch(Throwable err){
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	
	
	public void update(){
		Record dataRcord=(Record)getParameter("SamEsureyFamily");
		SamEsureyFamily dataBean=(SamEsureyFamily)dataRcord.toBean(SamEsureyFamily.class);
		dataBean.setCheckTime(DateUtil.getDay());
		service.update(dataBean);
	}
	
	public void check(){
		String signType = (String) getParameter("signType");
		SamEsureyFamily  bean=getSamEsureyFamily(signType);
		service.update(bean);
	}
	
	/**
	 * 1-区县民政局蒋核对请求转发给区县的经济核对中心
	 */
	public void submit(){
		String familyId = (String) getParameter("familyId");
		String checkOrgArea=(String)getParameter("checkOrgArea");
		String flag=(String)getParameter("flag");
		service.submit(familyId,checkOrgArea,flag);
		
	}
	/**
	 * 2-区县经济核对中心将核对请求上报给市经济核对中心
	 */
	public void centerSubmit(){
		String familyId = (String) getParameter("familyId");
		String checkOrgArea=(String)getParameter("checkOrgArea");
		String flag=(String)getParameter("flag");
		service.centerSubmit(familyId,checkOrgArea,flag);
		
	}

	public void delete(){
		String familyId=(String)getParameter("familyId");
		service.delete(familyId);
	}
	/*
	 * 删除赡养家庭
	 */
	public void deleteSupFamily(){
		String supFamId=(String)getParameter("supFamId");
		String familyId=(String)getParameter("familyId");
		service.deleteSupFamily(familyId,supFamId);
	}
	/**
	 * 家庭信息获取
	 * 
	 * @return
	 */
	private SamEsureyFamily getSamEsureyFamily(String signType) {
		Record SamEsureyFamilyRecord = (Record) getParameter("SamEsureyFamily");
		SamEsureyFamily bean = (SamEsureyFamily) SamEsureyFamilyRecord.toBean(SamEsureyFamily.class);
		  
		if ("insert".equals(signType)) {
			//登录人Id
			bean.setRegId(BspUtil.getEmpOrganId());
			//登录人姓名
			bean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			//登录单位Id
			bean.setRegOrgId(BspUtil.getCorpOrganId());
			//登录单位名称
			bean.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
			//录入时间
			bean.setRegTime(DateUtil.getTime());
		}else if("update".equals(signType)){
			//修改
			bean.setModId(BspUtil.getEmpOrganId());
			bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setModOrgId(BspUtil.getCorpOrganId());
			bean.setModOrg(BspUtil.getCorpOrgan().getOrganName());
			bean.setModTime(DateUtil.getTime());
		}else if("check".equals(signType)){
			//审核
			bean.setCheckId(BspUtil.getEmpOrganId());
			bean.setCheckPeople(BspUtil.getEmpOrgan().getOrganName());
			bean.setCheckOrgId(BspUtil.getCorpOrganId());
			bean.setCheckOrg(BspUtil.getCorpOrgan().getOrganName());
			bean.setCheckTime(DateUtil.getTime());
		} 
		return bean;
	}

/**
 * 家庭成员信息获取
 * 
 * @return
 */
private SamEsureyPeople getSamEsureyPeople(String signType) {
	Record SamEsureyPeopleRecord = (Record) getParameter("esureyPeople");
	SamEsureyPeople bean = (SamEsureyPeople) SamEsureyPeopleRecord.toBean(SamEsureyPeople.class);	
	if ("insert".equals(signType)) {
		//登录人Id
		bean.setRegId(BspUtil.getEmpOrganId());
		//登录人姓名
		bean.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
		//录入时间
		bean.setRegTime(DateUtil.getTime());
	}else{
		//修改人Id
		bean.setModId(BspUtil.getEmpOrganId());
		//修改人姓名
		bean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		//修改时间
		bean.setModTime(DateUtil.getTime());
	} 
	return bean;
}

/**
 * 查询是否存在相应的信息
 */
	public void beExistMess(){
		String idCard=(String)getParameter("idCard");
		setReturn("isExist",service.beExistMess(idCard));
	}
/**
 * 家庭成员信息回填
 */
	public void fillBackFamilyMember(String parentFamily,SamEsureyFamily bean,String isSupport){
		String familyId=bean.getFamilyId();
		String[] arr=parentFamily.split(",");
		String parentFamilyId=arr[0];
		String opSign=arr[1];
		List<SamEsureyPeople> peopleList=new ArrayList<SamEsureyPeople>();
		if(BASE_FAMILY.equals(opSign)){
			ParameterSet pset=new ParameterSet();
			pset.setParameter("FAMILY_ID", parentFamilyId);
			DataSet peopleDs=basePeopleService.queryYgjzJtxxCyxx(pset);
			for(int i=0;i<peopleDs.getCount();i++){
	             BaseinfoPeople basePeopleBean=(BaseinfoPeople)peopleDs.getRecord(i).toBean(BaseinfoPeople.class);
	             if(!HOUSE_HOLD.equals(basePeopleBean.getRelationshipType())){
	            	 SamEsureyPeople esureyPeoplebean=new SamEsureyPeople();
	            	 if("YES".equals(isSupport)){
	            	  esureyPeoplebean.setIsSupport("0");//赡养关系      		 
				     }
	            	 esureyPeoplebean.setPeopleId(IdHelp.getUUID32());
	            	 esureyPeoplebean.setFamilyId(familyId);
	            	 esureyPeoplebean.setRelationshipType(basePeopleBean.getRelationshipType());
	            	 esureyPeoplebean.setDomicileCode(basePeopleBean.getDomicileCode());
	            	 esureyPeoplebean.setApanageCode(basePeopleBean.getApanageCode());
	            	 esureyPeoplebean.setName(basePeopleBean.getName());
	            	 esureyPeoplebean.setIdCardType(basePeopleBean.getIdCardType());
	            	 esureyPeoplebean.setIdCard(basePeopleBean.getIdCard());
	            	 esureyPeoplebean.setSex(basePeopleBean.getSex());
	            	 esureyPeoplebean.setBirthday(basePeopleBean.getBirthday());
	            	 esureyPeoplebean.setNation(basePeopleBean.getNation());
	            	 esureyPeoplebean.setEduCode(basePeopleBean.getEduCode());
	            	 esureyPeoplebean.setHealthCode(basePeopleBean.getHealthCode());
	            	 esureyPeoplebean.setMarriageCode(basePeopleBean.getMarriageCode());
	            	 esureyPeoplebean.setCareerCode(basePeopleBean.getCareerCode());
	            	 esureyPeoplebean.setPoliticalCode(basePeopleBean.getPoliticalCode());
	            	 esureyPeoplebean.setDomicileType(basePeopleBean.getDomicileType());
	            	 esureyPeoplebean.setTelMobile(basePeopleBean.getTelMobile());
	            	 esureyPeoplebean.setTelOther(basePeopleBean.getTelOther());
	            	 esureyPeoplebean.setAddress(basePeopleBean.getAddress());
	            	 esureyPeoplebean.setPostCode(basePeopleBean.getPostCode());
	            	 esureyPeoplebean.setEmploymentCode(basePeopleBean.getEmploymentCode());
	            	 esureyPeoplebean.setWorkUnitName(basePeopleBean.getWorkUnitName());
	            	 esureyPeoplebean.setWorkUnitAdd(basePeopleBean.getWorkUnitAdd());
	            	 esureyPeoplebean.setWorkUnitTel(basePeopleBean.getWorkUnitTel());
	            	 esureyPeoplebean.setPersonalStatsTag("1");//个人状态标志--正常--‘1’
	            	 esureyPeoplebean.setIncomeMonth("0.00");
	            	 esureyPeoplebean.setIncomeYear("0.00");
	            	 peopleList.add(esureyPeoplebean);
	             }
			}
		}else if(ESUREY_FAMILY.equals(opSign)){
			ParameterSet pset=new ParameterSet();
			pset.setParameter("FAMILY_ID", parentFamilyId);
			DataSet peopleDs=peopleService.query(pset);
			for(int i=0;i<peopleDs.getCount();i++){
				SamEsureyPeople peopleBean=(SamEsureyPeople)peopleDs.getRecord(i).toBean(SamEsureyPeople.class);
				if(!HOUSE_HOLD.equals(peopleBean.getRelationshipType())){
					peopleBean.setPeopleId(IdHelp.getUUID32());
					peopleBean.setFamilyId(familyId);
					peopleList.add(peopleBean);
				}
			}
		}
		peopleService.batchInsert(peopleList);
	}
	
	/*
	 * 批量导入
	 */
		public void importExcel() {
			
			String erro = "";
			boolean editState = false;
			boolean addState = false;
			Boolean verify = true;
			String accountId = "";
			DataSet ds = new DataSet();
			DataSet dataSet = new DataSet();
			ParameterSet pset = new ParameterSet();
			SamEsureyFamily dataBean = new SamEsureyFamily();
			String FAMILY_TYPE=(String)getParameter("FAMILY_TYPE");
			String CUR_ACTIVITY=(String)getParameter("CUR_ACTIVITY");
			String CUR_STATE=(String)getParameter("CUR_STATE");
			String REG_ORG_ID=(String)getParameter("REG_ORG_ID");
			
			String REG_ADDRESS=(String)getParameter("REG_ADDRESS");
			String REG_ORG_NAME=(String)getParameter("REG_ADDRESS");
			String FAMILY_ADDRESS=(String)getParameter("FAMILY_ADDRESS");
			String reg_id = BspUtil.getEmpOrgan().getOrganId();
			String reg_people = BspUtil.getCorpOrgan().getOrganName();
			String reg_time=DateUtil.getTime();
			
			
			MultipartRequestWrapper request = (MultipartRequestWrapper) getRequest();
			Map<String, UploadFile> map = request.getUploadFiles();
			Set<Entry<String, UploadFile>> set = map.entrySet();
			Iterator<Entry<String, UploadFile>> iterator = set.iterator();
			UploadFile uploadFile = iterator.next().getValue();
			Workbook book = null;
			try {
				List<SamEsureyFamily> bankAccountAddList = new ArrayList<SamEsureyFamily>();
				List<SamEsureyFamily> bankAccountEditList = new ArrayList<SamEsureyFamily>();
				
				book = Workbook.getWorkbook(uploadFile.getInputStream());
				for (int k = 0; k < 1; k++) {
					Sheet sheet = book.getSheet(0);
					if(!("户主姓名".equals(sheet.getCell(0, 0).getContents()))){
						verify=false;
						erro = "模版第1行中第1列列名不正确！";
						break;
					}
					if(!("身份证件号码".equals(sheet.getCell(1, 0).getContents()))){
						verify=false;
						erro = "模版第1行中第2列列名不正确！";
						break;
					}
					
					for (int i = 1; i < sheet.getRows(); i++) {
						//判断第1列
						if(sheet.getCell(0, i).getContents().trim().length()==0){
							verify=false;
							erro = "模版第"+(i+1)+"行中的第1列“户主姓名”不能为空！";
							break;
						}
						//判断第2列
						if(sheet.getCell(1, i).getContents().trim().length()==0){
							verify=false;
							erro = "模版第"+(i+1)+"行中的第2列“身份证件号码”不能为空！";
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
						accountId = IdHelp.getUUID32();
							pset.setParameter("FAMILY_CARD_NO@=",sheet.getCell(1, i).getContents().trim());
							dataSet = dao.query(pset);
							if(dataSet.getCount() > 0){
								dataBean = (SamEsureyFamily) dataSet.getRecord(0).toBean(SamEsureyFamily.class);
								dataBean.setFamilyName(sheet.getCell(0, i).getContents().trim());//户主姓名
								dataBean.setFamilyCardNo(sheet.getCell(1, i).getContents().trim());//身份证号
								dataBean.setFamilyType(FAMILY_TYPE);
								dataBean.setCurActivity(CUR_ACTIVITY);
								dataBean.setCurState(CUR_STATE);
								dataBean.setRegOrgId(REG_ORG_ID);
								dataBean.setRegAddress(REG_ADDRESS);
								dataBean.setRegOrgName(REG_ORG_NAME);
								dataBean.setAssistanceType("1");//默认救助类型低收入家庭
								dataBean.setFamilyAddress(FAMILY_ADDRESS);
								dataBean.setRegId(reg_id);
								dataBean.setRegPeople(reg_people);
								dataBean.setRegTime(reg_time);
								dataBean.setDomicileType("1");//导入默认家庭性质为1（农村）
								bankAccountEditList.add(dataBean);
								editState = true;
							}else{
								dataBean = new SamEsureyFamily();
								dataBean.setFamilyId(accountId);
								dataBean.setFamilyName(sheet.getCell(0, i).getContents().trim());//户主姓名
								dataBean.setFamilyCardNo(sheet.getCell(1, i).getContents().trim());//身份证号
								dataBean.setFamilyType(FAMILY_TYPE);
								dataBean.setCurActivity(CUR_ACTIVITY);
								dataBean.setCurState(CUR_STATE);
								dataBean.setRegOrgId(REG_ORG_ID);
								dataBean.setRegAddress(REG_ADDRESS);
								dataBean.setRegOrgName(REG_ORG_NAME);
								dataBean.setAssistanceType("1");//默认救助类型低收入家庭
								dataBean.setFamilyAddress(FAMILY_ADDRESS);
								dataBean.setRegId(reg_id);
								dataBean.setRegPeople(reg_people);
								dataBean.setRegTime(reg_time);
								dataBean.setDomicileType("1");//导入默认家庭性质为1（农村）
								bankAccountAddList.add(dataBean);
								addState = true;
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
