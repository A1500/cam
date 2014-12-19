package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.IBptPeopleMartyrOffspringDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao;
import com.inspur.cams.bpt.base.data.BptApplyIntoprovince;
import com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring;
import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyMartyrOffspringDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * @title:BptPeopleMartyrOffspringCommand
 * @description: 部分烈士（错杀被平反人员）子女
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
public class BptPeopleMartyrOffspringCommand extends BaseAjaxCommand{
	
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	
	/**
	 * 获得优抚人员服务接口
	 */
	private IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,"bptPeopleDomain/bptPeopleDomain");	
	
	/**
	 * 获得【外省优抚人员抚恤关系迁入我省】服务接口
	 */
	private IBptApplyIntoprovinceDomain bptApplyIntoprovinceService = ScaComponentFactory
			.getService(IBptApplyIntoprovinceDomain.class,
					"BptApplyIntoprovinceDomain/BptApplyIntoprovinceDomain");
	
	/**
	 * 添加 部分烈士（错杀被平反人员）子女 信息
	 */
	@Trans
	public void insert(){
		
		IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
		IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		Record baseinfoPeopleRecord = (Record)getParameter("BaseinfoPeopleRecord");
		Record martyrOffspringRecord = (Record)getParameter("MartyrOffspringRecord");
		String peopleIdFlag = (String)getParameter("flag");
		
		//照片处理信息
		String peoplePhotoTemp = null;
		String nowTime = DateUtil.getTime();
		String areaCode = null;
		String employeeName = null;
		
		BaseinfoPeople baseinfopeople = null;
		BaseinfoFamily baseinfofamily = null;
		BptPeople bptPeople = null;
		BptPeopleMartyrOffspring martyrOffspringInfor = null;
		BptApplyMartyrOffspring martyrOffspringApplyInfor = null;
		
		String peopleId = null;
		String familyId = null;
		String applyId = IdHelp.getUUID32();
		if(("UPDATE".equals(idCardValidate((String)baseinfoPeopleRecord.get("idCard")))&&"1".equals(peopleIdFlag))
				||("INSERT".equals(idCardValidate((String)baseinfoPeopleRecord.get("idCard")))&&!"1".equals(peopleIdFlag))){
			throw new RuntimeException("插入标志不符:"+(String)baseinfoPeopleRecord.get("idCard")+
					"-"+idCardValidate((String)baseinfoPeopleRecord.get("idCard"))+"-"+peopleIdFlag);
			
		}
		if("1".equals(peopleIdFlag)){
			peopleId = IdHelp.getUUID32();
			familyId = IdHelp.getUUID32();
			
			baseinfopeople = getPeopleInfor(baseinfoPeopleRecord,peopleId,familyId);
			baseinfofamily = getFamilyInfor(baseinfoPeopleRecord,familyId);
			bptPeople = getBptPeopleInfor(martyrOffspringRecord,peopleId);
			martyrOffspringInfor = getMartyrOffspringInfor(martyrOffspringRecord,peopleId);
			martyrOffspringApplyInfor = getMartyrOffspringApplyInfor(applyId,peopleId);
			
			//照片信息
			peoplePhotoTemp = baseinfopeople.getPhotoTemp();
			areaCode = baseinfopeople.getRegOrgArea();
			employeeName = baseinfopeople.getRegPeople();
			
			dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
			service.insertBaseinfo(baseinfopeople, baseinfofamily);
			bptPeopleService.insert(bptPeople);
		}else{
			peopleId = (String)baseinfoPeopleRecord.get("peopleId");
			familyId = (String)baseinfoPeopleRecord.get("familyId");
			
			baseinfopeople = getPeopleInfor(baseinfoPeopleRecord,peopleId,familyId);
			baseinfofamily = getFamilyInfor(baseinfoPeopleRecord,familyId);
			bptPeople = getBptPeopleInfor(martyrOffspringRecord,peopleId);
			martyrOffspringInfor = getMartyrOffspringInfor(martyrOffspringRecord,peopleId);
			martyrOffspringApplyInfor = getMartyrOffspringApplyInfor(applyId,peopleId);
			
			//照片信息
			peoplePhotoTemp = baseinfopeople.getPhotoTemp();
			areaCode = baseinfopeople.getRegOrgArea();
			employeeName = baseinfopeople.getRegPeople();
			dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
			
			ParameterSet pset = new ParameterSet();
			 service.updateBaseinfo(baseinfopeople, baseinfofamily);
			pset.setParameter("PEOPLE_ID",peopleId);
			if(service.queryBptPeople(pset).getCount()==0){
				bptPeopleService.insert(bptPeople);
			}else{
				bptPeopleService.update(bptPeople);
			}
		}
		martyrOffspringDomain.insert(martyrOffspringInfor);
		applyMartyrOffspringDomain.insert(martyrOffspringApplyInfor);
		setReturn("applyId", applyId);
		setReturn("peopleId", peopleId);
		setReturn("familyId", familyId);
	}
	
	/**
	 * 添加 部分烈士（错杀被平反人员）子女 信息(数据采集)
	 */
	@Trans
	public void insertForCollection(){
		
		IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
		//IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		Record baseinfoPeopleRecord = (Record)getParameter("BaseinfoPeopleRecord");
		Record martyrOffspringRecord = (Record)getParameter("MartyrOffspringRecord");
		String peopleIdFlag = (String)getParameter("flag");
		
		//照片处理信息
		String peoplePhotoTemp = null;
		String nowTime = DateUtil.getTime();
		String areaCode = null;
		String employeeName = null;
		
		BaseinfoPeople baseinfopeople = null;
		BaseinfoFamily baseinfofamily = null;
		BptPeople bptPeople = null;
		BptPeopleMartyrOffspring martyrOffspringInfor = null;
		//BptApplyMartyrOffspring martyrOffspringApplyInfor = null;
		
		String peopleId = null;
		String familyId = null;
		String applyId = IdHelp.getUUID32();
		if(("UPDATE".equals(idCardValidate((String)baseinfoPeopleRecord.get("idCard")))&&"1".equals(peopleIdFlag))
				||("INSERT".equals(idCardValidate((String)baseinfoPeopleRecord.get("idCard")))&&!"1".equals(peopleIdFlag))){
			throw new RuntimeException("插入标志不符:"+baseinfopeople.getIdCard()+
					"-"+idCardValidate((String)baseinfoPeopleRecord.get("idCard"))+"-"+peopleIdFlag);
			
		}
		if("1".equals(peopleIdFlag)){
			peopleId = IdHelp.getUUID32();
			familyId = IdHelp.getUUID32();
			
			baseinfopeople = getBaseinfoPeopleForCollection(baseinfoPeopleRecord,peopleId,familyId);
			baseinfofamily = getFamilyInfor(baseinfoPeopleRecord,familyId);
			bptPeople = getBptPeopleInfor(martyrOffspringRecord,peopleId);
			martyrOffspringInfor = getMartyrOffspringInfor(martyrOffspringRecord,peopleId);
			
			//照片信息
			peoplePhotoTemp = baseinfopeople.getPhotoTemp();
			areaCode = baseinfopeople.getRegOrgArea();
			employeeName = baseinfopeople.getRegPeople();
			
			dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
			service.insertBaseinfo(baseinfopeople, baseinfofamily);
			bptPeopleService.insert(bptPeople);
		}else{
			peopleId = (String)baseinfoPeopleRecord.get("peopleId");
			familyId = (String)baseinfoPeopleRecord.get("familyId");
			
			baseinfopeople = getBaseinfoPeopleForCollection(baseinfoPeopleRecord,peopleId,familyId);
			baseinfofamily = getFamilyInfor(baseinfoPeopleRecord,familyId);
			bptPeople = getBptPeopleInfor(martyrOffspringRecord,peopleId);
			martyrOffspringInfor = getMartyrOffspringInfor(martyrOffspringRecord,peopleId);
			
			//照片信息
			peoplePhotoTemp = baseinfopeople.getPhotoTemp();
			areaCode = baseinfopeople.getRegOrgArea();
			employeeName = baseinfopeople.getRegPeople();
			dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
			
			ParameterSet pset = new ParameterSet();
			 service.updateBaseinfo(baseinfopeople, baseinfofamily);
			pset.setParameter("PEOPLE_ID",peopleId);
			if(service.queryBptPeople(pset).getCount()==0){
				bptPeopleService.insert(bptPeople);
			}else{
				bptPeopleService.update(bptPeople);
			}
		}
		martyrOffspringDomain.insert(martyrOffspringInfor);
		setReturn("applyId", applyId);
		setReturn("peopleId", peopleId);
		setReturn("familyId", familyId);
	}
	
	/**
	 * 修改部分烈士（错杀被平反人员）子女信息
	 */
	@Trans
	public void update(){
		Record martyrOffspringRecord = (Record)getParameter("MartyrOffspringRecord");
		String peopleId = (String)martyrOffspringRecord.get("peopleId");
		IBptPeopleMartyrOffspringDao martyrOffspringDao = (IBptPeopleMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleMartyrOffspringDao");
		BptPeopleMartyrOffspring martyrOffspringInfor = (BptPeopleMartyrOffspring)martyrOffspringRecord.toBean(BptPeopleMartyrOffspring.class);
		martyrOffspringDao.update(martyrOffspringInfor);
		BptPeople bptPeople = getUpdateBptPeopleInfor(martyrOffspringRecord,peopleId);
		bptPeopleService.update(bptPeople);
	}
	/**
	 * 修改部分烈士（错杀被平反人员）子女信息(数据采集)
	 */
	@Trans
	public void updateColllection(){
		Record martyrOffspringRecord = (Record)getParameter("MartyrOffspringRecord");
		String peopleId = (String)martyrOffspringRecord.get("peopleId");
		IBptPeopleMartyrOffspringDao martyrOffspringDao = (IBptPeopleMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleMartyrOffspringDao");
		BptPeopleMartyrOffspring martyrOffspringInfor = (BptPeopleMartyrOffspring)martyrOffspringRecord.toBean(BptPeopleMartyrOffspring.class);
		martyrOffspringDao.update(martyrOffspringInfor);
		BptPeople bptPeople = getUpdateBptPeopleInfor(martyrOffspringRecord,peopleId);
		bptPeopleService.update(bptPeople);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet ds = service.queryPeople(pset);
		if(ds.getCount()>0){
			Record r = ds.getRecord(0);
			r.set("martyrOffspringStateCode", martyrOffspringRecord.get("martyrOffspringStateCode"));
			r.set("martyrOffspringNo", martyrOffspringRecord.get("martyrOffspringNo"));
			service.updateBaseinfoPeople((BaseinfoPeople)r.toBean(BaseinfoPeople.class));
		}
		
	}
	/**
	 * 获得人员信息
	 * @param baseinfoPeopleRecord
	 * @param peopleId
 	 * @param familyId
	 * @return 
	 */
	public BaseinfoPeople getPeopleInfor(Record baseinfoPeopleRecord,String peopleId,String familyId){
		BaseinfoPeople peopleInfor = (BaseinfoPeople)baseinfoPeopleRecord.toBean(BaseinfoPeople.class);
		peopleInfor.setPeopleId(peopleId);
		peopleInfor.setFamilyId(familyId);
		peopleInfor.setMartyrOffspringFlag("1");
		peopleInfor.setMartyrOffspringStateCode("1");
		peopleInfor.setPersonalStatsTag("0");
		peopleInfor.setRegId(BspUtil.getEmpOrganId());
		peopleInfor.setRegTime(DateUtil.getTime());
		peopleInfor.setModId(BspUtil.getEmpOrganId());
		peopleInfor.setModTime(DateUtil.getTime());
		return peopleInfor;
	}
	/**
	 * 获得人员信息(数据采集)
	 * @param baseinfoPeopleRecord
	 * @param peopleId
 	 * @param familyId
	 * @return 
	 */
	public BaseinfoPeople getBaseinfoPeopleForCollection(Record baseinfoPeopleRecord,String peopleId,String familyId){
		BaseinfoPeople peopleInfor = (BaseinfoPeople)baseinfoPeopleRecord.toBean(BaseinfoPeople.class);
		peopleInfor.setPeopleId(peopleId);
		peopleInfor.setFamilyId(familyId);
		peopleInfor.setMartyrOffspringFlag("1");
		//peopleInfor.setMartyrOffspringStateCode("1");
		peopleInfor.setPersonalStatsTag("0");
		peopleInfor.setRegId(BspUtil.getEmpOrganId());
		peopleInfor.setRegTime(DateUtil.getTime());
		peopleInfor.setModId(BspUtil.getEmpOrganId());
		peopleInfor.setModTime(DateUtil.getTime());
		return peopleInfor;
	}
	
	/**
	 * 获取家庭信息
	 * @param baseinfoPeopleRecord
	 * @param familyId
	 * @return
	 */
	public BaseinfoFamily getFamilyInfor(Record baseinfoPeopleRecord,String familyId){
		BaseinfoFamily bean = new BaseinfoFamily();
		bean.setFamilyId(familyId);
		bean.setFamilyName((String)baseinfoPeopleRecord.get("name"));
		bean.setFamilyCardNo((String)baseinfoPeopleRecord.get("idCard"));
		bean.setDomicileCode((String)baseinfoPeopleRecord.get("domicileCode"));
		bean.setApanageCode((String)baseinfoPeopleRecord.get("apanageCode"));
		bean.setFamilyCardType("0");
		bean.setFamilyStateFlag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**
	 * 获取 部分烈士（错杀被平反人员）子女 实体
	 * @param martyrOffspringRecord
	 * @param peopleId
	 * @return
	 */
	public BptPeopleMartyrOffspring getMartyrOffspringInfor(Record martyrOffspringRecord,String peopleId){
		BptPeopleMartyrOffspring bean = (BptPeopleMartyrOffspring)martyrOffspringRecord.toBean(BptPeopleMartyrOffspring.class);
		bean.setPeopleId(peopleId);
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**
	 * 获取 bptPeople 实体
	 * @param martyrOffspringRecord
	 * @param peopleId
	 * @return
	 */
	public BptPeople getBptPeopleInfor(Record martyrOffspringRecord,String peopleId){
		BptPeople bptPeople = new BptPeople();
		ParameterSet param = new ParameterSet();
		String marPeopleId = (String)martyrOffspringRecord.get("peopleId");
		if(marPeopleId!=null&&!marPeopleId.equals("")&&!"0".equals(marPeopleId)){
			param.setParameter("PEOPLE_ID",marPeopleId);
			DataSet ds =service.queryBptPeople(param);
			bptPeople = (BptPeople)ds.getRecord(0).toBean(BptPeople.class);
			bptPeople.setBank((String)martyrOffspringRecord.get("bank"));
			bptPeople.setAccountCode((String)martyrOffspringRecord.get("accountCode"));
			bptPeople.setAccountName((String)martyrOffspringRecord.get("accountName"));
			bptPeople.setOldLonelyFlag((String)martyrOffspringRecord.get("oldLonelyFlag"));
			bptPeople.setWorkAbilityCode((String)martyrOffspringRecord.get("workAbilityCode"));
			bptPeople.setMartyrOffspringCode("B1");
		}else{
			bptPeople = (BptPeople)martyrOffspringRecord.toBean(BptPeople.class);
			bptPeople.setPeopleId(peopleId);
			bptPeople.setDisabilityTypeCode("00");
			bptPeople.setDependantTypeCode("00");
			bptPeople.setDemobilizedTyepCode("00");
			bptPeople.setRedaTypeCode("00");
			bptPeople.setWarTypeCode("00");
			bptPeople.setRetiredTypeCode("00");
			bptPeople.setInsanityFlag("0");
			bptPeople.setMartyrOffspringCode("B1");
		}
		return bptPeople;
	}
	
	/**
	 * 获取修改时的部分烈士（错杀被平反人员）子女信息
	 * @param martyrOffspringRecord
	 * @param peopleId
	 * @return
	 */
	public BptPeople getUpdateBptPeopleInfor(Record martyrOffspringRecord,String peopleId){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet ds = bptPeopleService.query(pset);
		Record rd = ds.getRecord(0);
		BptPeople dataBean = (BptPeople)rd.toBean(BptPeople.class); 
		dataBean.setOldLonelyFlag((String)martyrOffspringRecord.get("oldLonelyFlag"));
		dataBean.setOrphanFlag((String)martyrOffspringRecord.get("orphanFlag"));
		dataBean.setWorkAbilityCode((String)martyrOffspringRecord.get("workAbilityCode"));
		dataBean.setViabilityCode((String)martyrOffspringRecord.get("viabilityCode"));
		dataBean.setSupportPattern((String)martyrOffspringRecord.get("supportPattern"));
		dataBean.setBank((String)martyrOffspringRecord.get("bank"));
		dataBean.setAccountCode((String)martyrOffspringRecord.get("accountCode"));
		dataBean.setAccountName((String)martyrOffspringRecord.get("accountName"));
		return dataBean;
	}
	
	/**
	 * 获取 年满60周岁农村籍退役士兵 申请信息
	 * @param applyId
	 * @param peopleId
	 * @return
	 */
	public BptApplyMartyrOffspring getMartyrOffspringApplyInfor(String applyId,String peopleId){
		BptApplyMartyrOffspring bean = new BptApplyMartyrOffspring();
		bean.setApplyId(applyId);
		bean.setPeopleId(peopleId);
		bean.setApplyDate(DateUtil.getDay());
		bean.setApproveOrganId(BspUtil.getOrganCode());
		bean.setServiceType("B1");
		bean.setCommitFlag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**家庭成员
	 * 照片处理(申请人证件照片、申请人现场照片)
	 * @param icmApplyInfo
	 */
	@Trans
	public void dealPhotoC(BaseinfoPeople bean,String nowTime,String areaCode,String employeeName,String peoplePhotoTemp) {
		// 采集证件照片
		String applybase64Code = "";
		String applycardbase64Code = "";
		String applyId = "";
		applybase64Code = bean.getPhotoTemp();
		applycardbase64Code=bean.getCardPhotoTemp();
		if (null != applybase64Code && !"".equals(applybase64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			applyId = PhotoUtil.savePhoto(bean.getPhotoTemp(),bean.getCardPhotoTemp());
		}

		if (applyId != null && !"".equals(applyId)) {
			bean.setPhotoId(applyId);
		}
	}
	
	/**
	 * 插入外省迁入信息
	 */
	@Trans
	public void insertIntoProvi(){

		IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
		IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
		Record baseinfoPeopleRecord = (Record)getParameter("BaseinfoPeopleRecord");
		Record martyrOffspringRecord = (Record)getParameter("MartyrOffspringRecord");
		String peopleIdFlag = (String)baseinfoPeopleRecord.get("peopleId");
		
		//照片处理信息
		String peoplePhotoTemp = null;
		String nowTime = DateUtil.getTime();
		String areaCode = null;
		String employeeName = null;
		
		BaseinfoPeople baseinfopeople = null;
		BaseinfoFamily baseinfofamily = null;
		BptPeople bptPeople = null;
		BptPeopleMartyrOffspring martyrOffspringInfor = null;
		
		String peopleId = null;
		String familyId = null;
		
		String applyId = IdHelp.getUUID32();
		if("0".equals(peopleIdFlag)){
			peopleId = IdHelp.getUUID32();
			familyId = IdHelp.getUUID32();
			
			baseinfopeople = getPeopleInfor(baseinfoPeopleRecord,peopleId,familyId);
			baseinfofamily = getFamilyInfor(baseinfoPeopleRecord,familyId);
			bptPeople = getBptPeopleInfor(martyrOffspringRecord,peopleId);
			martyrOffspringInfor = getMartyrOffspringInfor(martyrOffspringRecord,peopleId);
			
			//照片信息
			peoplePhotoTemp = baseinfopeople.getPhotoTemp();
			areaCode = baseinfopeople.getRegOrgArea();
			employeeName = baseinfopeople.getRegPeople();
			
			dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
			service.insertBaseinfo(baseinfopeople, baseinfofamily);
			bptPeopleService.insert(bptPeople);
		}else{
			peopleId = (String)baseinfoPeopleRecord.get("peopleId");
			familyId = (String)baseinfoPeopleRecord.get("familyId");
			
			baseinfopeople = getPeopleInfor(baseinfoPeopleRecord,peopleId,familyId);
			baseinfofamily = getFamilyInfor(baseinfoPeopleRecord,familyId);
			bptPeople = getBptPeopleInfor(martyrOffspringRecord,peopleId);
			martyrOffspringInfor = getMartyrOffspringInfor(martyrOffspringRecord,peopleId);
			
			//照片信息
			peoplePhotoTemp = baseinfopeople.getPhotoTemp();
			areaCode = baseinfopeople.getRegOrgArea();
			employeeName = baseinfopeople.getRegPeople();
			dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
			
			ParameterSet pset = new ParameterSet();
			 service.updateBaseinfo(baseinfopeople, baseinfofamily);
			pset.setParameter("PEOPLE_ID",peopleId);
			if(service.queryBptPeople(pset).getCount()==0){
				bptPeopleService.insert(bptPeople);
			}else{
				bptPeopleService.update(bptPeople);
			}
		}
		martyrOffspringDomain.insert(martyrOffspringInfor);
		
		
		Record MartyrOffspringRecord = (Record)getParameter("MartyrOffspringRecord");
		BptApplyIntoprovince dataBean = (BptApplyIntoprovince) MartyrOffspringRecord.toBean(BptApplyIntoprovince.class);
		dataBean.setApplyId(applyId);
		dataBean.setPeopleId(peopleId);
		dataBean.setCommitFlag("0");
		bptApplyIntoprovinceService.insert(dataBean);
		
		setReturn("applyId", applyId);
		setReturn("peopleId", peopleId);
		setReturn("familyId", familyId);
	}
	
	/**
	 * 修改外省迁入信息
	 */
	@Trans
	public void updateIntoProvi(){
		update();
		Record MartyrOffspringRecord = (Record)getParameter("MartyrOffspringRecord");
		BptApplyIntoprovince dataBean = (BptApplyIntoprovince) MartyrOffspringRecord.toBean(BptApplyIntoprovince.class);
		dataBean.setServiceType("B2");
		dataBean.setCommitFlag("0");
		bptApplyIntoprovinceService.update(dataBean);
	}
	public String idCardValidate(String idCard){
		BptPeopleValidateDao dao = (BptPeopleValidateDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("idCard", idCard);
		DataSet ds = dao.validateBptPeople(pset);
		if(ds.getCount()>0){
			return "UPDATE";
		}else{
			return "INSERT";
		}
	}
}
