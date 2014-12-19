package com.inspur.cams.bpt.manage.cmd;


import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.dao.jdbc.BptDemobilizedillCheckDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao;
import com.inspur.cams.bpt.base.domain.IBptApplyDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyEmigrationDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.base.domain.IBptDecisionLetterDomain;
import com.inspur.cams.bpt.base.domain.IBptOpenLetterDomain;
import com.inspur.cams.bpt.base.domain.IBptProvinceMigrateDomain;
import com.inspur.cams.bpt.base.domain.IDisabilityIdentificationDomain;
import com.inspur.cams.bpt.base.domain.IDisabilityNoticeDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.dichealth.dao.DicHealth;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.print.dao.jdbc.AssDisabilityAppPrintDao;


/**
 * @title:BptPeopleWarQueryCommand
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
public class DocumentDocCommand extends BaseAjaxCommand{
	
	private StringBuffer str =new StringBuffer();
	
	/**
	 * 公式书
	 */
	private IBptOpenLetterDomain openService = ScaComponentFactory.getService(IBptOpenLetterDomain.class,
		"bptOpenLetterDomain/bptOpenLetterDomain");
	/**
	 * 决定书
	 */
	private IBptDecisionLetterDomain decisionLetterService = ScaComponentFactory.getService(IBptDecisionLetterDomain.class,
	"bptDecisionLetterDomain/bptDecisionLetterDomain");
	
	
	/**
	 * 获得受理通知书服务接口
	 */
	private IDisabilityNoticeDomain disabilityNoticeService = ScaComponentFactory.getService(IDisabilityNoticeDomain.class,
	"disabilityNoticeDomain/disabilityNoticeDomain");	
	
	/**
	 * 获得伤残鉴定介绍信服务接口
	 */
	private IDisabilityIdentificationDomain identiService = ScaComponentFactory
			.getService(IDisabilityIdentificationDomain.class,
					"disabilityIdentificationDomain/disabilityIdentificationDomain");
	/**
	 * 获得体检表服务接口
	 */
	private BptPhysicalExaminationDao physicalExaminationdao = (BptPhysicalExaminationDao) DaoFactory
		.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao");
	//送检表
	private BptDemobilizedillCheckDao checkdao = (BptDemobilizedillCheckDao) DaoFactory
		.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptDemobilizedillCheckDao");
	public void getDoc(){
		
		ParameterSet pset = getParameterSet();
		String service =(String)pset.get("service");
		pset.remove("service");
		if("TestAndWar".equals(service)) {
			getTestAndWarDoc(pset);
		} else if("Disability".equals(service)){
			getDisabilityDoc(pset);
		}  else if("Democile".equals(service)){
			getDemocileDoc(pset);
		} else if("SoldierAndMarty".equals(service)){
			getMartyAndSoldierDoc(pset);
		}
		this.setReturn("map", str.toString());
	}
	
	/**
	 * 获取已填写参战参试文书
	 * @param pset
	 */
	private void getTestAndWarDoc(ParameterSet pset){
		String serviceType =(String)pset.get("service_type");
		DataSet ds;
		if("51".equals(serviceType)) {//参战申请
			ds = decisionLetterService.queryDecisionLetter(pset);
			setMap(ds,"foundation","decision");
			pset.remove("service_type");
			ds = openService.queryOpenLetter(pset);
			setMap(ds,"law","open");
		} else if("61".equals(serviceType)){
			pset.remove("service_type");
			ds = openService.queryOpenLetter(pset);
			setMap(ds,"law","open");
			ds = physicalExaminationdao.query(pset);
			setMap(ds,"applyReason","examination");
		} 
	}
	
	/**
	 * 获取已填写60周岁,部分烈士子女文书
	 * @param pset
	 */
	private void getMartyAndSoldierDoc(ParameterSet pset){
		String serviceType =(String)pset.get("service_type");
		DataSet ds;
		if("81".equals(serviceType)||"B1".equals(serviceType)) {
			pset.remove("service_type");
			ds = openService.queryOpenLetter(pset);
			setMap(ds,"openDate","open");
		} 
	}
	
	/**
	 * 获取已填写伤残文书
	 * @param pset
	 */
	private void getDisabilityDoc(ParameterSet pset){
		String serviceType =(String)pset.get("service_type");
		DataSet ds;
		if("11".equals(serviceType)||"12".equals(serviceType)) {
			pset.remove("service_type");
			ds = disabilityNoticeService.query(pset);
			setMap(ds,"letter","notice");
			ds = identiService.query(pset);
			setMap(ds,"identificationUnit","identity");
			ds = openService.queryOpenLetter(pset);
			setMap(ds,"law","open");
			ds = decisionLetterService.queryDecisionLetter(pset);
			setMap(ds,"foundation","decision");
			ds = physicalExaminationdao.query(pset);
			setMap(ds,"applyReason","examination");
		} 
		if("11".equals(serviceType)){
			String applyid = (String)pset.get("apply_id");
			pset.setParameter("apply_id", applyid+"@");
			ds = physicalExaminationdao.query(pset);
			setMap(ds,"applyReason","testexamination");
			
		}
	}
	
	
	
	/**
	 * 获取已填写在乡复员、带病回乡文书
	 * @param pset
	 */
	private void getDemocileDoc(ParameterSet pset){
		String serviceType =(String)pset.get("service_type");
		DataSet ds;
		if("41".equals(serviceType)) {
			pset.remove("service_type");
			ds = decisionLetterService.queryDecisionLetter(pset);
			setMap(ds,"foundation","decision");
			ds = openService.queryOpenLetter(pset);
			setMap(ds,"law","open");
	    } else if("45".equals(serviceType)){
	    	pset.remove("service_type");
	    	ds = decisionLetterService.queryDecisionLetter(pset);
			setMap(ds,"foundation","decision");
			ds = openService.queryOpenLetter(pset);
			setMap(ds,"law","open");
			ds = physicalExaminationdao.query(pset);
			setMap(ds,"conclusion","examination");
			ds = checkdao.query(pset);
			setMap(ds,"hospital","check");
	    }
	}
	public void setMap(DataSet ds ,String field,String name){
		if(ds.getCount()>0){
			Record r = ds.getRecord(0);
			if(!"".equals(r.get(field))&&(r.get(field))!=null){
				str.append(name+";");
			}
		}
	}
}
