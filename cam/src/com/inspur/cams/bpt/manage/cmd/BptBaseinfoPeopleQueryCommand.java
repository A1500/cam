package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.skin.SkinUtils;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.IBptPeopleDao;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleExpandDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * @title:BptBaseinfoPeopleQueryCommand
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
public class BptBaseinfoPeopleQueryCommand extends BaseQueryCommand{
	
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
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
	
	/**
	 * 伤残人员信息服务接口
	 */
	IBptPeopleDomain bptPeopleDomain = ScaComponentFactory.getService(IBptPeopleDomain.class,
	"bptPeopleDomain/bptPeopleDomain");
	
	/**
	 * 查询家庭信息
	 * @return
	 */
	//获取人员基本信息扩展表dao
	IBaseinfoPeopleExpandDao BaseinfoPeopelExpandDao = (IBaseinfoPeopleExpandDao) DaoFactory
    .getDao("com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoPeopleExpandDao");
	public DataSet queryFamilyInfo(){
		ParameterSet pset = getParameterSet();
		return service.queryFamilyInfo(pset);
	}
	
	/**
	 * 查询人员信息
	 * @return
	 */
	public DataSet queryPeopleInfo(){
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
				String apanageName = apanageCodeRecord.get("fullName").toString();
				peopleRecord.set("apanageName", apanageName);
			}
			list.add(peopleRecord);
		}	

		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(list.size());
		return ds;
			
		// return new DataSet(peopleRecord);
		// }else{
			//return peopleDataSet;
		// }
	}
	/**
	 * 查询人员信息
	 * @return
	 */
	public DataSet queryFamilyPeopleInfo(){
		ParameterSet pset = getParameterSet();
		DataSet peopleDataSet =  service.queryPeople(pset);
		//if(peopleDataSet.getCount()==1){
		ArrayList list = new ArrayList();
		
		peopleDataSet.addField("domicileName");
		peopleDataSet.addField("apanageName");
		
		for(int i=0;i<peopleDataSet.getCount();i++){
			Record peopleRecord = peopleDataSet.getRecord(i);
			DataSet BaseinfoPeopelExpandSet = new DataSet();
			if(!pset.containsKey("ID_CARD@=")&&!pset.containsKey("ID")){
			if(BaseinfoPeopelExpandDao.query(pset).getCount()!=0){
			 BaseinfoPeopelExpandSet = BaseinfoPeopelExpandDao.query(pset);
			Record BaseinfoPeopelExpandRecord = BaseinfoPeopelExpandSet.getRecord(i);
			String isWork = (String)BaseinfoPeopelExpandRecord.get("isWork");
			String isStudy = (String)BaseinfoPeopelExpandRecord.get("isStudy");
			
			if(isWork!=null||isWork!=""){
				peopleRecord.set("isWork",isWork);
			}
			if(isWork!=null||isWork!=""){
				peopleRecord.set("isStudy",isStudy);
			}
			}
			}
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
				String apanageName = apanageCodeRecord.get("fullName").toString();
				peopleRecord.set("apanageName", apanageName);
			}
			list.add(peopleRecord);
		}	

		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(list.size());
		return ds;
			
		// return new DataSet(peopleRecord);
		// }else{
			//return peopleDataSet;
		// }
	}
	
	 /**
	 * 查询优抚对像基本信息列表
	 */
	public DataSet queryBPTObjectInfo() {
		ParameterSet pset = getParameterSet();
		IBptPeopleDao  bptPeopleDao = (IBptPeopleDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDao");
        return bptPeopleDao.queryBPTObjectInfo(pset);
	}
	/**
	 * 查询优抚对像基本信息列表
	 */
	public DataSet queryBPTPeopleInfo() {
		ParameterSet pset = getParameterSet();
		IBptPeopleDao  bptPeopleDao = (IBptPeopleDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDao");
        return bptPeopleDao.queryPeopleInfo(pset);
	}
	/**
	 * 查询优抚对像申请信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleService(){
		ParameterSet pset = getParameterSet();
		IBptPeopleDao  bptPeopleDao = (IBptPeopleDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDao");
		return bptPeopleDao.queryPeopleService(pset);
	}
	/**
	 * 查询优抚伤残减员人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDecreaseBpt() {
		ParameterSet pset = getParameterSet();
		return bptPeopleDomain.queryDecreaseBpt(pset);
	}
	
	/**
	 * 查询优抚增员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryIncreaseBpt() {
		ParameterSet pset = getParameterSet();
		return bptPeopleDomain.queryIncreaseBpt(pset);
	}
	
	/**
	 *  根据人员Id查询人员信息
	 */
	public DataSet queryPeopleInfoByPeoId(){
		ParameterSet pset = getParameterSet();
		Record rd = wfProcessBusinessService.query(pset).getRecord(0);
		String peopleId = ((String)rd.get("connectId"));
		pset.remove("process_Id");
		pset.setParameter("people_Id", peopleId);
		return service.queryPeople(pset);
	}
	
	/**
	 * 根据人员Id查询家庭信息
	 */
	public DataSet queryFamInfByProcessId(){
		ParameterSet pset = getParameterSet();
		Record rd = wfProcessBusinessService.query(pset).getRecord(0);
		String peopleId = ((String)rd.get("connectId"));
		pset.setParameter("people_Id", peopleId);
		pset.remove("process_Id");
		Record rd1 = service.queryPeople(pset).getRecord(0);
		String familyId = (String)rd1.get("familyId");
		pset.setParameter("family_Id", familyId);
		pset.remove("people_Id");
		return service.queryFamilyInfo(pset);
	}
	
	/**
	 * 
	 * 根据身份证IdCard查询人员信息
	 */
	public DataSet queryBaseInfoPeople(){
		ParameterSet pset = getParameterSet();
		
		DataSet peopleDataSet =  service.queryPeople(pset);
	    if(peopleDataSet.getCount() !=0 ){
	    	ArrayList list = new ArrayList();
			peopleDataSet.addField("domicileName");
			peopleDataSet.addField("apanageName");
			
			Record peopleRecord = peopleDataSet.getRecord(0);
			EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
			.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			
			//获取domicileName
			String domicileCode = peopleRecord.get("domicileCode")==null?null:peopleRecord.get("domicileCode").toString();
			if(domicileCode !=null&&!domicileCode.equals("")){
				pset.clear();
				pset.setParameter("ID", domicileCode);
				DataSet domicileCodeDataSet = dao.query(pset);
				Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
				String domicileName = domicileCodeRecord.get("name").toString();			
				peopleRecord.set("domicileName", domicileName);			}
			//获取apanageName
			String apanageCode = peopleRecord.get("apanageCode")==null?null:peopleRecord.get("apanageCode").toString();
			if(apanageCode!=null&&!apanageCode.equals(""))
			{
				pset.clear();
				pset.setParameter("ID", apanageCode);
				DataSet apanageCodeDataSet = dao.query(pset);
				Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
				String apanageName = apanageCodeRecord.get("name").toString();
				peopleRecord.set("apanageName", apanageName);
			}
	    }
	    /*else{
	    	BaseinfoPeople bean =new BaseinfoPeople();
	    	//DataSet ds =  new DataSet();
	    	peopleDataSet.addField("domicileName");
	    	peopleDataSet.addField("apanageName");
	    	peopleDataSet.addRecord(bean);
	    	//return ds;
	    }*/
	    sipPhotoPath(peopleDataSet);
	    return peopleDataSet;
		  
	  }
	
	/**
	 * 设置照片路径 
	 * 
	 * @param ds
	 */
	public void sipPhotoPath(DataSet ds) {
		String rootUrl = SkinUtils.getRootUrl(getRequest()); 
		if (ds.getCount() != 0) {
			for (int i = 0; i < ds.getCount(); i++) {
				Record record = ds.getRecord(i);
				BaseinfoPeople baseinfoPoeple = (BaseinfoPeople) record
						.toBean(BaseinfoPeople.class);
				String photoId = baseinfoPoeple.getPhotoId();
				String photoTable = "COM_PHOTO";
				if (photoId != null && photoId.length() > 0) {
					photoTable = photoTable + "_" + photoId.substring(0, 6);
				}
				String photoPath = rootUrl + "download?table=" + photoTable
						+ "&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"
						+ photoId+"'"; // 生成照片路径
				record.set("photoTemp", photoPath);
			}
		}
	}
	
	
	
	/**
	 * 根据ProcessId或者assignmentId查 peopleId 、familyId
	 */
	public Map queryPeopleByProcessId(String processId, String assignmentId) {
		Map<String, String> map = new HashMap<String, String>();
		String peopleId = null;
		String familyId = null;
		String applyId = null;
		String serviceType = null;
		ParameterSet pset = new ParameterSet();

		if ((processId == null || "".equals(processId)) && assignmentId != null
				&& !"".equals(assignmentId)) {
			processId = wfProcessBusinessService.getProcessId(assignmentId);
		}
		pset.setParameter("PROCESS_ID", processId);
		Record rd = wfProcessBusinessService.query(pset).getRecord(0);
		peopleId = ((String) rd.get("connectId"));
		applyId = ((String) rd.get("businessId"));  
		serviceType = (String) rd.get("businessType");
		pset.remove("PROCESS_ID");
		pset.setParameter("PEOPLE_ID", peopleId);

		DataSet ds = service.queryPeople(pset);
		if (ds.getCount() != 0) {
			familyId = ((BaseinfoPeople) service.queryPeople(pset).getRecord(0)
					.toBean(BaseinfoPeople.class)).getFamilyId();
		}
		map.put("peopleId", peopleId);
		map.put("familyId", familyId);
		map.put("applyId", applyId);
		map.put("serviceType", serviceType);
		return map;

	}
	
	/**
	 * 根据ProcessId查 peopleId 、familyId
	 */
	public Map queryPeopleByProcessId(String processId){
		Map<String, Object> map = new HashMap<String, Object>();


		ParameterSet pset = new ParameterSet();
		pset.setParameter("PROCESS_ID", processId);
		String peopleId=null;
		String familyId=null;
		String applyId=null;
		String serviceType = null;
		
			Record rd = wfProcessBusinessService.query(pset).getRecord(0);
			 peopleId = ((String)rd.get("connectId"));
			 applyId = ((String)rd.get("businessId"));
			 serviceType = (String) rd.get("businessType");
			 pset.remove("PROCESS_ID");
			 pset.setParameter("PEOPLE_ID", peopleId);
			 familyId= DemobilizedService.queryByProcessId(pset);
			map.put("peopleId",peopleId);
			map.put("familyId",familyId);
			map.put("applyId",applyId);
			map.put("serviceType", serviceType);
		return map;
		
	}
	/**
	 * 查询人员各种审批信息
	 * @return
	 */
	public DataSet queryApplyInfo(){
		IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,
		"bptPeopleDomain/bptPeopleDomain");
		ParameterSet pset = getParameterSet();
		return bptPeopleService.queryApplyInfo(pset);
	}
	/**
	 * 查询人口数量
	 * @return
	 */
	public DataSet queryPeopleNumInfo(){
		IBptPeopleDomain bptPeopleService = ScaComponentFactory.getService(IBptPeopleDomain.class,
		"bptPeopleDomain/bptPeopleDomain");
		ParameterSet pset = getParameterSet();
		return bptPeopleService.queryPeopleNumInfo(pset);
	}
	
	/**
	 * 查询60岁服兵役年限人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet querySoldierYear(){
		ParameterSet pset = getParameterSet();
		return bptPeopleDomain.querySoldierYear(pset);
	}
	
	/**
	 * 查询身份证号重复人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryRepeatIdcard() {
		ParameterSet pset = getParameterSet();
		IBptPeopleDao  bptPeopleDao = (IBptPeopleDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDao");
        return  bptPeopleDao.queryRepeatIdcard(pset);
	}
	
	/**
	 * 查询双重身份人员
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDoubleIdentity() {
		ParameterSet pset = getParameterSet();
		IBptPeopleDao  bptPeopleDao = (IBptPeopleDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDao");
        return  bptPeopleDao.queryDoubleIdentity(pset);
	}
}