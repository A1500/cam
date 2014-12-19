package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.IBptApplyMartyrOffspringDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao;
import com.inspur.cams.bpt.base.data.BptApplyIntoprovince;
import com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring;
import com.inspur.cams.bpt.base.data.BptCountRetiredSoldier;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * @title:BptCountRetiredSoldierCommand
 * @description:
 * @author:
 * @since:2011-08-04
 * @version:1.0
*/
public class BptCountRetiredSoldierCommand extends BaseAjaxCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	private BptCountRetiredSoldierDao dao = (BptCountRetiredSoldierDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
	private IBptApplyMartyrOffspringDao Applydao = (IBptApplyMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
	/**
	 * 获得【外省优抚人员抚恤关系迁入我省】服务接口
	 */
	private IBptApplyIntoprovinceDomain bptApplyIntoprovinceService = ScaComponentFactory
			.getService(IBptApplyIntoprovinceDomain.class,
					"BptApplyIntoprovinceDomain/BptApplyIntoprovinceDomain");
	@Trans
	public void insert() {
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfopeople = getBaseinfoPeople();
		BaseinfoFamily baseinfofamily = getBaseinfoFamily();
		BptCountRetiredSoldier bptCountRetiredSoldier = getBptCountRetiredSoldier();
		BptPeople bptPeople = getBptPeople();
		
		
		String peoplePhotoTemp=baseinfopeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode=baseinfopeople.getRegOrgArea();
		String employeeName=baseinfopeople.getRegPeople();
		dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片		
		String applyId = IdHelp.getUUID30();
		BptApplyMartyrOffspring bptApplyCountrySoldier= null;
		if(("UPDATE".equals(idCardValidate(baseinfopeople.getIdCard()))&&"1".equals(flag))
				||("INSERT".equals(idCardValidate(baseinfopeople.getIdCard()))&&!"1".equals(flag))){
			throw new RuntimeException("插入标志不符:"+baseinfopeople.getIdCard()+
					"-"+idCardValidate(baseinfopeople.getIdCard())+"-"+flag);
			
		}
		if("1".equals(flag)){
			String peopleIdRe = IdHelp.getUUID30();
	     	String familyIdRe = IdHelp.getUUID30();
	     	baseinfopeople.setPeopleId(peopleIdRe);
	     	baseinfopeople.setFamilyId(familyIdRe);
	     	baseinfofamily.setFamilyId(familyIdRe);
	     	bptPeople.setPeopleId(peopleIdRe);
	     	bptCountRetiredSoldier.setPeopleId(peopleIdRe);
	     	bptApplyCountrySoldier=getCountRetirdSoldierApplyInfor(applyId,peopleIdRe);
			service.insertBaseinfo(baseinfopeople, baseinfofamily);
			service.insertBptPeople(bptPeople);
			dao.insert(bptCountRetiredSoldier);
		}else{
			service.updateBaseinfo(baseinfopeople, baseinfofamily);
			String peopleId = baseinfopeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID",peopleId);
			bptApplyCountrySoldier=getCountRetirdSoldierApplyInfor(applyId,peopleId);
			if(service.queryBptPeople(pset).getCount()==0){
			service.insertBptPeople(bptPeople);
			}else{
			service.update(bptPeople);
			} 
			List list =new ArrayList();
			list.add(bptCountRetiredSoldier);
			dao.save(list);
		}
		Applydao.insert(bptApplyCountrySoldier);
		setReturn("peopleId", baseinfopeople.getPeopleId());
	    setReturn("familyId", baseinfopeople.getFamilyId());
	    setReturn("applyId", applyId);
	}
    
	/**
	 *	获取人员信息
	 * author:
	 * since:2011-05-16
	 */
	private BaseinfoPeople getBaseinfoPeople() {
		Record retiredSoldierRecord = (Record) getParameter("RetiredSoldierRecord");
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag(baseinfopeopleRecord.get("disabilityFlag").toString());
		bean.setRedaFlag(baseinfopeopleRecord.get("redaFlag").toString());
		bean.setDependantFlag(baseinfopeopleRecord.get("dependantFlag").toString());
		bean.setDemobilizedFlag(baseinfopeopleRecord.get("demobilizedFlag").toString());
		bean.setDisabilityStateCode(baseinfopeopleRecord.get("disabilityStateCode").toString());
		bean.setRedaStateCode(baseinfopeopleRecord.get("redaStateCode").toString());
		bean.setDependantStateCode(baseinfopeopleRecord.get("dependantStateCode").toString());
		bean.setDemobilizedStateCode(baseinfopeopleRecord.get("demobilizedStateCode").toString());
        //bean.setWarStateCode(retiredSoldierRecord.get("warStateCode").toString());
		//bean.setWarNo(retiredSoldierRecord.get("warNo").toString());
		bean.setRetiredFlag("1");
		bean.setRetiredStateCode("1");
		bean.setPersonalStatsTag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**
	 * 插入60岁退役士兵信息(数据采集)
	 */
	@Trans
	public void insertForCollection() {
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfopeople = getBaseinfoPeopleForCollection();
		BaseinfoFamily baseinfofamily = getBaseinfoFamily();
		BptCountRetiredSoldier bptCountRetiredSoldier = getBptCountRetiredSoldier();
		BptPeople bptPeople = getBptPeople();
		
		
		String peoplePhotoTemp=baseinfopeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode=baseinfopeople.getRegOrgArea();
		String employeeName=baseinfopeople.getRegPeople();
		dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片		
		String applyId = IdHelp.getUUID30();
		//BptApplyMartyrOffspring bptApplyCountrySoldier= null;
		if(("UPDATE".equals(idCardValidate(baseinfopeople.getIdCard()))&&"1".equals(flag))
				||("INSERT".equals(idCardValidate(baseinfopeople.getIdCard()))&&!"1".equals(flag))){
			throw new RuntimeException("插入标志不符:"+baseinfopeople.getIdCard()+
					"-"+idCardValidate(baseinfopeople.getIdCard())+"-"+flag);
			
		}
		if(flag.equals("1")){
			String peopleIdRe = IdHelp.getUUID30();
	     	String familyIdRe = IdHelp.getUUID30();
	     	baseinfopeople.setPeopleId(peopleIdRe);
	     	baseinfopeople.setFamilyId(familyIdRe);
	     	baseinfofamily.setFamilyId(familyIdRe);
	     	bptPeople.setPeopleId(peopleIdRe);
	     	bptCountRetiredSoldier.setPeopleId(peopleIdRe);
	     	//bptApplyCountrySoldier=getCountRetirdSoldierApplyInfor(applyId,peopleIdRe);
			service.insertBaseinfo(baseinfopeople, baseinfofamily);
			service.insertBptPeople(bptPeople);
			dao.insert(bptCountRetiredSoldier);
		}else{
			service.updateBaseinfo(baseinfopeople, baseinfofamily);
			String peopleId = baseinfopeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID",peopleId);
			//bptApplyCountrySoldier=getCountRetirdSoldierApplyInfor(applyId,peopleId);
			if(service.queryBptPeople(pset).getCount()==0){
			service.insertBptPeople(bptPeople);
			}else{
			service.update(bptPeople);
			} 
			dao.insert(bptCountRetiredSoldier);
		}
		//Applydao.insert(bptApplyCountrySoldier);
		setReturn("peopleId", baseinfopeople.getPeopleId());
	    setReturn("familyId", baseinfopeople.getFamilyId());
	    setReturn("applyId", applyId);
	}
    
	/**
	 *	获取人员信息(数据采集)
	 * author:
	 * since:2011-05-16
	 */
	private BaseinfoPeople getBaseinfoPeopleForCollection() {
		Record retiredSoldierRecord = (Record) getParameter("RetiredSoldierRecord");
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag(baseinfopeopleRecord.get("disabilityFlag").toString());
		bean.setRedaFlag(baseinfopeopleRecord.get("redaFlag").toString());
		bean.setDependantFlag(baseinfopeopleRecord.get("dependantFlag").toString());
		bean.setDemobilizedFlag(baseinfopeopleRecord.get("demobilizedFlag").toString());
		bean.setDisabilityStateCode(baseinfopeopleRecord.get("disabilityStateCode").toString());
		bean.setRedaStateCode(baseinfopeopleRecord.get("redaStateCode").toString());
		bean.setDependantStateCode(baseinfopeopleRecord.get("dependantStateCode").toString());
		bean.setDemobilizedStateCode(baseinfopeopleRecord.get("demobilizedStateCode").toString());
        //bean.setWarStateCode(retiredSoldierRecord.get("warStateCode").toString());
		//bean.setWarNo(retiredSoldierRecord.get("warNo").toString());
		bean.setRetiredFlag("1");
		//bean.setRetiredStateCode("1");
		bean.setPersonalStatsTag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	
	
	/**
	 *	获取家庭信息
	 */
	private BaseinfoFamily getBaseinfoFamily() {
		Record baseinfoPeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		//BaseinfoFamily bean = (BaseinfoFamily) baseinfofamilyRecord.toBean(BaseinfoFamily.class);
		BaseinfoFamily bean = new BaseinfoFamily();
		bean.setFamilyId(baseinfoPeopleRecord.get("familyId").toString());
		bean.setFamilyName(baseinfoPeopleRecord.get("name").toString());
		bean.setFamilyCardNo(baseinfoPeopleRecord.get("idCard").toString());
		bean.setDomicileCode(baseinfoPeopleRecord.get("domicileCode").toString());
		bean.setApanageCode(baseinfoPeopleRecord.get("apanageCode").toString());
		bean.setFamilyCardType("0");
		bean.setFamilyStateFlag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	
	/**
	 * 获得优抚人员信息
	 */
	private BptPeople getBptPeople(){
		Record retiredSoldierRecord = (Record) getParameter("RetiredSoldierRecord");
		BptPeople bptPeople=(BptPeople)retiredSoldierRecord.toBean(BptPeople.class);
			bptPeople.setPeopleId(retiredSoldierRecord.get("peopleId").toString());
			bptPeople.setRetiredTypeCode("81");
			bptPeople.setInsanityFlag("0");
			bptPeople.setOldLonelyFlag(retiredSoldierRecord.get("oldLonelyFlag").toString());
			bptPeople.setWorkAbilityCode(retiredSoldierRecord.get("workAbilityCode").toString());
			//bptPeople.setWorkAbilityDescribe(retiredSoldierRecord.get("workAbilityDescribe").toString());
			bptPeople.setViabilityCode("1");
			bptPeople.setSupportPattern("1");
			//bptPeople.setJobStatusDescribe(retiredSoldierRecord.get("jobStatusDescribe").toString());
			bptPeople.setBank(retiredSoldierRecord.get("bank").toString());
			bptPeople.setAccountCode(retiredSoldierRecord.get("accountCode").toString());
			bptPeople.setAccountName(retiredSoldierRecord.get("accountName").toString());
			//将该对象修改为多个对象类别
			ParameterSet param = new ParameterSet();
			param.setParameter("PEOPLE_ID", retiredSoldierRecord.get("peopleId").toString());
			DataSet ds =service.queryBptPeople(param);
			if(ds.getCount()!=0){
				Record rd =  ds.getRecord(0);
				bptPeople.setWarTypeCode(rd.get("warTypeCode").toString());
				bptPeople.setDisabilityTypeCode(rd.get("disabilityTypeCode").toString());
				bptPeople.setDependantTypeCode(rd.get("dependantTypeCode").toString());
				bptPeople.setRedaTypeCode(rd.get("redaTypeCode").toString());
			    bptPeople.setDemobilizedTyepCode(rd.get("demobilizedTyepCode").toString());
			    bptPeople.setMartyrOffspringCode((String)rd.get("martyrOffspringCode"));
			}else{
				bptPeople.setDisabilityTypeCode("00");
				bptPeople.setDependantTypeCode("00");
				bptPeople.setRedaTypeCode("00");
			    bptPeople.setDemobilizedTyepCode("00");
			    bptPeople.setWarTypeCode("00");
			    bptPeople.setMartyrOffspringCode("00");
		    }
		return bptPeople;
	}
	
	/**
	 *  获取退役士兵信息
	 */
	private BptCountRetiredSoldier getBptCountRetiredSoldier(){
		Record rd =(Record)getParameter("RetiredSoldierRecord");
		BptCountRetiredSoldier bean = (BptCountRetiredSoldier) rd.toBean(BptCountRetiredSoldier.class);
		bean.setPeopleId(rd.get("peopleId").toString());
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
	 * 获取 获取 部分烈士（错杀被平反人员）子女 申请信息
	 * @param applyId
	 * @param peopleId
	 * @return
	 */
	public BptApplyMartyrOffspring getCountRetirdSoldierApplyInfor(String applyId,String peopleId){
		BptApplyMartyrOffspring bean = new BptApplyMartyrOffspring();
		bean.setApplyId(applyId);
		bean.setPeopleId(peopleId);
		bean.setApplyDate(DateUtil.getDay());
		bean.setApproveOrganId(BspUtil.getOrganCode());
		bean.setServiceType("81");
		bean.setCommitFlag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	/**
	 * 更新人员信息、优抚信息
	 */
	@Trans
	public void update(){
		BptCountRetiredSoldier bptCountRetiredSoldier = getBptCountRetiredSoldier();
		BptPeople bptPeople = getBptPeople();
		dao.update(bptCountRetiredSoldier);
		service.update(bptPeople);
	}
	/**
	 * 更新人员信息、优抚信息(数据采集)
	 */
	@Trans
	public void updateCollection(){
		update();
		Record rd =(Record)getParameter("RetiredSoldierRecord");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", (String)rd.get("peopleId"));
		DataSet ds = service.queryPeople(pset);
		if(ds.getCount()>0){
			Record r = ds.getRecord(0);
			r.set("retiredStateCode", (String)rd.get("retiredStateCode"));
			r.set("retiredNo", (String)rd.get("pretiredNo"));
			service.updateBaseinfoPeople((BaseinfoPeople)r.toBean(BaseinfoPeople.class));
		}
	}
	/**
	 * 修改外省迁入信息
	 */
	@Trans
	public void updateIntoProvi(){
		update();
		Record MartyrOffspringRecord = (Record)getParameter("RetiredSoldierRecord");
		BptApplyIntoprovince dataBean = (BptApplyIntoprovince) MartyrOffspringRecord.toBean(BptApplyIntoprovince.class);
		dataBean.setServiceType("82");
		dataBean.setCommitFlag("0");
		bptApplyIntoprovinceService.update(dataBean);
	}
	
	@Trans
	public void insertIngoingsSoldier() {
		
		
		String flag = (String) getParameter("flag");
		BaseinfoPeople baseinfopeople = getBaseinfoPeople();
		BaseinfoFamily baseinfofamily = getBaseinfoFamily();
		BptCountRetiredSoldier bptCountRetiredSoldier = getBptCountRetiredSoldier();
		BptPeople bptPeople = getBptPeople();
		
		
		String peoplePhotoTemp=baseinfopeople.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String areaCode=baseinfopeople.getRegOrgArea();
		String employeeName=baseinfopeople.getRegPeople();
		dealPhotoC(baseinfopeople, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片		
		String applyId = IdHelp.getUUID30();
		BptApplyMartyrOffspring bptApplyCountrySoldier= null;
		if(flag.equals("1")){
			String peopleIdRe = IdHelp.getUUID30();
	     	String familyIdRe = IdHelp.getUUID30();
	     	baseinfopeople.setPeopleId(peopleIdRe);
	     	baseinfopeople.setFamilyId(familyIdRe);
	     	baseinfofamily.setFamilyId(familyIdRe);
	     	bptPeople.setPeopleId(peopleIdRe);
	     	bptCountRetiredSoldier.setPeopleId(peopleIdRe);
			service.insertBaseinfo(baseinfopeople, baseinfofamily);
			service.insertBptPeople(bptPeople);
			dao.insert(bptCountRetiredSoldier);
		}else{
			service.updateBaseinfo(baseinfopeople, baseinfofamily);
			String peopleId = baseinfopeople.getPeopleId();
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PEOPLE_ID",peopleId);
			if(service.queryBptPeople(pset).getCount()==0){
				service.insertBptPeople(bptPeople);
			}else{
				service.update(bptPeople);
			} 
			dao.update(bptCountRetiredSoldier);
		}
		Record MartyrOffspringRecord = (Record)getParameter("RetiredSoldierRecord");
		BptApplyIntoprovince dataBean = (BptApplyIntoprovince) MartyrOffspringRecord.toBean(BptApplyIntoprovince.class);
		dataBean.setApplyId(applyId);
		dataBean.setPeopleId(baseinfopeople.getPeopleId());
		dataBean.setCommitFlag("0");
		bptApplyIntoprovinceService.insert(dataBean);
		setReturn("peopleId", baseinfopeople.getPeopleId());
	    setReturn("familyId", baseinfopeople.getFamilyId());
	    setReturn("applyId", applyId);
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
