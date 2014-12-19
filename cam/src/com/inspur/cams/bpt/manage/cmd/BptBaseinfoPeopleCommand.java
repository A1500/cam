package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.IBptPeopleDao;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleExpandDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeopleExpand;
import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.PhotoUtil;


/**
 * @title:BaseinfoPeopleSaveCommand
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
public class BptBaseinfoPeopleCommand extends BaseAjaxCommand {
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	/**
	 * 保存家庭和人员信息 
	 */
	@Trans
	public void save() {
		IBptBaseinfoPeopleDomain service = ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
				"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
		BaseinfoPeople baseinfopeople = getBaseinfoPeople();
		BaseinfoFamily baseinfofamily = getBaseinfoFamily();
		service.saveList(baseinfopeople, baseinfofamily);
	}
	
	/**
	 * 添加人员信息
	 */	
	@Trans
	public void insertPeople(){
		IBptBaseinfoPeopleDomain service = ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
		"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople)baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag("0");
		bean.setRedaFlag("0");
		bean.setDependantFlag("0");
		bean.setDemobilizedFlag("0");
		bean.setWarFlag("0");
		bean.setDisabilityStateCode("0");
		bean.setRedaStateCode("0");
		bean.setDependantStateCode("0");
		bean.setDemobilizedStateCode("0");
		bean.setWarStateCode("0");
		bean.setPersonalStatsTag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		service.insertPeople(bean);
		
	}
	
	/**
	 * 添加家庭成员信息
	 */
	@Trans
	public void insertFamilyPeople(){
		IBaseinfoPeopleExpandDao BaseinfoPeopelExpandDao = (IBaseinfoPeopleExpandDao) DaoFactory
        .getDao("com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoPeopleExpandDao");
		IBptBaseinfoPeopleDomain service = ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
		"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		
		String peopleId = baseinfopeopleRecord.get("peopleId").toString();
		ParameterSet peoplePset = new ParameterSet();
		peoplePset.setParameter("PEOPLE_ID", peopleId);
		if(service.queryBaseinfoPeople(peoplePset).getCount()==0){
			BaseinfoPeople bean = (BaseinfoPeople)baseinfopeopleRecord.toBean(BaseinfoPeople.class);
			BaseinfoPeopleExpand expandBean = (BaseinfoPeopleExpand)baseinfopeopleRecord.toBean(BaseinfoPeopleExpand.class);
			bean.setIdCardType("0");
			bean.setDisabilityFlag("0");
			bean.setRedaFlag("0");
			bean.setDependantFlag("0");
			bean.setDemobilizedFlag("0");
			bean.setWarFlag("0");
			bean.setDisabilityStateCode("0");
			bean.setRedaStateCode("0");
			bean.setDependantStateCode("0");
			bean.setDemobilizedStateCode("0");
			bean.setWarStateCode("0");
			bean.setPersonalStatsTag("0");
			bean.setRegId(BspUtil.getEmpOrganId());
			bean.setRegTime(DateUtil.getTime());
			bean.setModId(BspUtil.getEmpOrganId());
			bean.setModTime(DateUtil.getTime());
			service.insertPeople(bean);
			BaseinfoPeopelExpandDao.insert(expandBean);
			
			String relationShipType = baseinfopeopleRecord.get("relationshipType").toString();
			if("0".equals(relationShipType)){
				String familyId = baseinfopeopleRecord.get("familyId").toString();
				ParameterSet pset = getParameterSet();
				pset.clear();
				pset.setParameter("FAMILY_ID", familyId);
				DataSet ds = service.queryBaseinfoFamily(pset);
				Record rd = ds.getRecord(0);
				rd.set("familyName", baseinfopeopleRecord.get("name").toString());
				rd.set("familyCardNo", baseinfopeopleRecord.get("idCard").toString());
				BaseinfoFamily dataBean = (BaseinfoFamily)rd.toBean(BaseinfoFamily.class);
				BaseinfoPeopleExpand expandDataBean = (BaseinfoPeopleExpand)rd.toBean(BaseinfoPeopleExpand.class);
				service.updateBaseinfoFamily(dataBean);
				BaseinfoPeopelExpandDao.update(expandDataBean);
			}
		}else{
			BaseinfoPeople bean = (BaseinfoPeople)baseinfopeopleRecord.toBean(BaseinfoPeople.class);
			BaseinfoPeopleExpand expandBean = (BaseinfoPeopleExpand)baseinfopeopleRecord.toBean(BaseinfoPeopleExpand.class);
			service.updateBaseinfoPeople(bean);
			BaseinfoPeopelExpandDao.update(expandBean);
		}
	}

	/**
	 *  修改人员信息
	 */
	@Trans
	public void updatePeople(){
		//获取人员基本信息扩展表dao
		IBaseinfoPeopleExpandDao BaseinfoPeopelExpandDao = (IBaseinfoPeopleExpandDao) DaoFactory
	    .getDao("com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoPeopleExpandDao");
		IBptBaseinfoPeopleDomain service = ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
		"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
		
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		String serviceType = (String)getParameter("serviceType");
		String applyId = (String)getParameter("applyId");
		BaseinfoPeople bean = (BaseinfoPeople)baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		BaseinfoPeopleExpand expandDataBean = (BaseinfoPeopleExpand)baseinfopeopleRecord.toBean(BaseinfoPeopleExpand.class);
		String peoplePhotoTemp=bean.getPhotoTemp();
		String nowTime = DateUtil.getTime();
		String familyId = bean.getFamilyId();//家庭ID
		String areaCode=bean.getRegOrgArea();
		String employeeName=bean.getRegPeople();
		dealPhotoC(bean, nowTime, areaCode, employeeName,peoplePhotoTemp);//处理照片
		service.updateBaseinfoPeople(bean);
		BaseinfoPeopelExpandDao.update(expandDataBean);
		//修改人员信息后，修改其他关联表中的相关信息，只修改审批之前表
		if(serviceType!=null&&(!serviceType.equals(""))&&applyId!=null&&(!applyId.equals(""))){
			IBptPeopleDao bptPeopleDao = (IBptPeopleDao) DaoFactory
		    .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDao");
			ParameterSet pset = new ParameterSet();
			pset.setParameter("record", baseinfopeopleRecord);
			pset.setParameter("serviceType",serviceType);
			pset.setParameter("applyId",applyId);
			bptPeopleDao.updatePeopleRelatedInfor(pset,baseinfopeopleRecord);
		}
	}
	
	/**
	 * 修改家庭信息
	 */
	@Trans
	public void updateFamily(){
		IBptBaseinfoPeopleDomain service = ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
		"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
		Record baseinfofamilyRecord = (Record) getParameter("BaseinfoFamilyRecord");
		BaseinfoFamily bean = (BaseinfoFamily) baseinfofamilyRecord.toBean(BaseinfoFamily.class);
		service.updateBaseinfoFamily(bean);
	}
	
	/**
	 *	获取人员信息
	 * author:
	 * since:2011-05-16
	 */
	private BaseinfoPeople getBaseinfoPeople() {
		Record baseinfopeopleRecord = (Record) getParameter("BaseinfoPeopleRecord");
		BaseinfoPeople bean = (BaseinfoPeople) baseinfopeopleRecord.toBean(BaseinfoPeople.class);
		bean.setIdCardType("0");
		bean.setDisabilityFlag("0");
		bean.setRedaFlag("0");
		bean.setDependantFlag("0");
		bean.setDemobilizedFlag("0");
		bean.setWarFlag("0");
		bean.setDisabilityStateCode("0");
		bean.setRedaStateCode("0");
		bean.setDependantStateCode("0");
		bean.setDemobilizedStateCode("0");
		bean.setWarStateCode("0");
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
		Record baseinfofamilyRecord = (Record) getParameter("BaseinfoFamilyRecord");
		BaseinfoFamily bean = (BaseinfoFamily) baseinfofamilyRecord.toBean(BaseinfoFamily.class);
		bean.setFamilyCardType("0");
		bean.setFamilyStateFlag("0");
		bean.setRegId(BspUtil.getEmpOrganId());
		bean.setRegTime(DateUtil.getTime());
		bean.setModId(BspUtil.getEmpOrganId());
		bean.setModTime(DateUtil.getTime());
		return bean;
	}
	/**
	 * 根据ProcessId查peopleId
	 */
	public void queryByProcessId(){
		/**
		 * 在乡复员人员信息服务接口
		 */
		IBptPeopleDemobilizedDomain DemobilizedService = ScaComponentFactory.getService(IBptPeopleDemobilizedDomain.class,
		"bptPeopleDemobilizedDomain/bptPeopleDemobilizedDomain");
		/**
		 * 工作流信息服务接口
		 */
		IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
		"wfProcessBusinessDomain/wfProcessBusinessDomain");
		ParameterSet pset = getParameterSet();
		DataSet ds = null;
		String peopleId=null;
		if(pset.containsKey("PROCESS_ID")){
			Record rd = wfProcessBusinessService.query(pset).getRecord(0);
			 peopleId = ((String)rd.get("connectId"));
			ds = DemobilizedService.queryDemobilizedFlowHeader(peopleId);
		}else{
			String assignmentId = (String)pset.getParameter("assignmentId");
			String processId = wfProcessBusinessService.getProcessId(assignmentId);
			pset.clear();
			pset.setParameter("PROCESS_ID", processId);
			Record rd = wfProcessBusinessService.query(pset).getRecord(0);
			 peopleId = ((String)rd.get("connectId"));
			ds = DemobilizedService.queryDemobilizedFlowHeader(peopleId);
		}
			
		setReturn("peopleId",peopleId);
		
	}
	
	/**家庭成员
	 * 照片处理(申请人证件照片、申请人现场照片)
	 * @param icmApplyInfo
	 */
	@Trans
	public void dealPhotoC(BaseinfoPeople bean,String nowTime,String areaCode,String employeeName,String peoplePhotoTemp) {
		// 采集证件照片
		String applybase64Code = "";
		String applyId = "";
		String applycardbase64Code = "";
		applybase64Code = bean.getPhotoTemp();
		applycardbase64Code=bean.getCardPhotoTemp();
		if (null != applybase64Code && !"".equals(applybase64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			//applyId = PhotoUtil.savePhoto(bean.getPhotoTemp());
			applyId = PhotoUtil.savePhoto(bean.getPhotoTemp(),bean.getCardPhotoTemp());
		}

		if (applyId != null && !"".equals(applyId)) {
			bean.setPhotoId(applyId);
		}

	}
	
	/**
	 * 获得photo_id
	 * 
	 * @param peopleId
	 * @return
	 */
	public String findPhotoId(String peopleId) {
		IBptBaseinfoPeopleDomain service = ScaComponentFactory.getService(
				IBptBaseinfoPeopleDomain.class,
				"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet ds= service.queryBaseinfoPeople(pset);
		if(ds.getCount()>0){
			return ((BaseinfoPeople) ds.getRecord(0)
					.toBean(BaseinfoPeople.class)).getPhotoId();
		}else
			return "";
	}
	/**
	 * 查询人员信息
	 * @return
	 */
	public void queryPeopleInfo(){
		ParameterSet pset = getParameterSet();
		DataSet peopleDataSet =  service.queryPeople(pset);
		//if(peopleDataSet.getCount()==1){
		ArrayList list = new ArrayList();
		
		peopleDataSet.addField("domicileName");
		peopleDataSet.addField("apanageName");
		
		for(int i=0;i<peopleDataSet.getCount();i++){
			Record peopleRecord = peopleDataSet.getRecord(i);
			EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
			.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			
			//获取domicileName
			if(peopleRecord.get("domicileCode")!=null&&peopleRecord.get("domicileCode")!=""){
				String domicileCode = peopleRecord.get("domicileCode").toString();
				pset.clear();
				pset.setParameter("ID", domicileCode);
				DataSet domicileCodeDataSet = dao.query(pset);
				Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
				String domicileName = (String)domicileCodeRecord.get("fullName");
				peopleRecord.set("domicileName", domicileName);
			}
			
			//获取apanageName
			if(peopleRecord.get("apanageCode")!=null&&peopleRecord.get("apanageCode")!=""){
				String apanageCode = peopleRecord.get("apanageCode").toString();
				pset.clear();
				pset.setParameter("ID", apanageCode);
				DataSet apanageCodeDataSet = dao.query(pset);
				Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
				String apanageName = apanageCodeRecord.get("name").toString();
				peopleRecord.set("apanageName", apanageName);
			}
			list.add(peopleRecord);
		}	

		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(list.size());
		String address = (String)peopleDataSet.getRecord(0).get("address");
		String domicileAddress = (String)peopleDataSet.getRecord(0).get("domicileAddress");
		setReturn("address",address);
		setReturn("domicileAddress",domicileAddress);
			
		// return new DataSet(peopleRecord);
		// }else{
			//return peopleDataSet;
		// }
	}
	
	public void  getMsgForNOPrint (){
		ParameterSet pset = getParameterSet();
		IBptPeopleDao  bptPeopleDao = (IBptPeopleDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDao");
        String str =  bptPeopleDao.getMsgForNOPrint(pset);
        this.setReturn("msg",str);
	}
	
	
	/**
	 * 用于修改人员身份证号是查询身份证信息用
	 * @return
	 */
	public void queryHavePeople(){
		ParameterSet pset = getParameterSet();
		DataSet peopleDataSet =  service.queryPeople(pset);
		if(peopleDataSet.getCount()>0){
			String disabilityFlag  = (String)peopleDataSet.getRecord(0).get("disabilityFlag");
			String dependantFlag  = (String)peopleDataSet.getRecord(0).get("dependantFlag");
			String warFlag  = (String)peopleDataSet.getRecord(0).get("warFlag");
			String martyrOffspringFlag  = (String)peopleDataSet.getRecord(0).get("martyrOffspringFlag");
			String retiredFlag  = (String)peopleDataSet.getRecord(0).get("retiredFlag");
			String demobilizedFlag  = (String)peopleDataSet.getRecord(0).get("demobilizedFlag");
			if(!"1".equals(disabilityFlag)&&!"1".equals(dependantFlag)
					&&!"1".equals(warFlag)&&!"1".equals(martyrOffspringFlag)
					&&!"1".equals(retiredFlag)&&!"1".equals(demobilizedFlag)){
				setReturn("havePeople","havedel");
			}else{
				setReturn("havePeople","hava");
			}
		}else {
			
			setReturn("havePeople","nohave");
		}
		
	}
	
}