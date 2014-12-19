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

import com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.data.BptCountRetiredSoldier;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.domain.IBptApplyDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptStateChangeCommand
 * @description:
 * @author:
 * @since:2011-05-25
 * @version:1.0
*/
public class BptStateChangeCommand extends BaseAjaxCommand{
	 
	//状态变更接口
	private IBptStateChangeDomain stateChangeService = ScaComponentFactory.getService(IBptStateChangeDomain.class,
			"bptStateChangeDomain/bptStateChangeDomain");
	
	//人员信息接口
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	
	/**
	 * 获得伤残人员服务接口
	 */
	IBptPeopleDisabilityDomain bptPeopleDisabilityService = ScaComponentFactory
			.getService(IBptPeopleDisabilityDomain.class,
					"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");
	IBptPeopleDependantDomain dependantService = ScaComponentFactory.getService(IBptPeopleDependantDomain.class,
			"bptPeopleDependantDomain/bptPeopleDependantDomain");

	IBptPeopleDemobilizedDomain demobilizedService = ScaComponentFactory.getService(IBptPeopleDemobilizedDomain.class,
			"bptPeopleDemobilizedDomain/bptPeopleDemobilizedDomain");
	IBptPeopleDemobilizedIllnessDomain demobilizedIllnessService = ScaComponentFactory.getService(IBptPeopleDemobilizedIllnessDomain.class,
			"demobilizedIllnessDomain/demobilizedIllnessDomain");
	 BptCountRetiredSoldierDao ptCountRetiredSoldierDao = (BptCountRetiredSoldierDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
	 IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
	 IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
	 
	 /**
		 * 获得参战人员服务接口
		 */
		IBptPeopleTestedDomain iBptPeopleTestedService = ScaComponentFactory.getService(IBptPeopleTestedDomain.class,"bptPeopleTestedDomain/bptPeopleTestedDomain");
	@Trans
	public void insert() {
		BptStateChange bptStateChange = getBptStateChange();
		stateChangeService.insertBptStateChange(bptStateChange);
		updateTypeBean(bptStateChange);
		BaseinfoPeople baseinfoPeople = getBaseinfoPeople();
		service.updateBaseinfoPeople(baseinfoPeople);
	}
	@Trans
	public void update(){
		BptStateChange bptStateChange = getUpdateBptStateChange();
		updateTypeBean(bptStateChange);
		stateChangeService.update(bptStateChange);
		stateChangeService.updateClass(bptStateChange);
		
	}

	public void updateTypeBean(BptStateChange bptStateChange){
		Record record = (Record) getParameter("StateChangeRecord");
		String objectType = (String)getParameter("objectType");
		String changeStateSuf = (String)record.get("changeStateSuf");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("people_Id", (String)record.get("peopleId"));
			if("1".equals(objectType.substring(0,1))){
				DataSet ds =bptPeopleDisabilityService.queryBptPeopleDisability(pset);
				if(ds.getCount()>0){
					BptPeopleDisability b =(BptPeopleDisability)ds.getRecord(0).toBean(BptPeopleDisability.class);
					if("7".equals(changeStateSuf)){//去世
						b.setCancellationDate((String)record.get("deathDate"));
					}else if("8".equals(changeStateSuf)){//取消
						b.setCancellationDate(bptStateChange.getChangeStateDate());
					}
					bptPeopleDisabilityService.updatePeopleDisability(b);
					
				}
				
			}else if("2".equals(objectType.substring(0,1))){
				DataSet ds =dependantService.query(pset);
				if(ds.getCount()>0){
					BptPeopleDependant b =(BptPeopleDependant)ds.getRecord(0).toBean(BptPeopleDependant.class);
					if("7".equals(changeStateSuf)){//去世
						b.setCancellationDate((String)record.get("deathDate"));
					}else if("8".equals(changeStateSuf)){//取消
						b.setCancellationDate(bptStateChange.getChangeStateDate());
					}
					dependantService.update(b);
				}
			}else if("41".equals(objectType)){
				DataSet ds =demobilizedService.query(pset);
				if(ds.getCount()>0){
					BptPeopleDemobilized b =(BptPeopleDemobilized)ds.getRecord(0).toBean(BptPeopleDemobilized.class);
					if("7".equals(changeStateSuf)){//去世
						b.setCancellationDate((String)record.get("deathDate"));
					}else if("8".equals(changeStateSuf)){//取消
						b.setCancellationDate(bptStateChange.getChangeStateDate());
					}
					demobilizedService.updateBptPeopleDemobilized(b);
					
				}
			}else if("42".equals(objectType)){
				DataSet ds =demobilizedIllnessService.query(pset);
				if(ds.getCount()>0){
					BptPeopleDemobilizedIllness b =(BptPeopleDemobilizedIllness)ds.getRecord(0).toBean(BptPeopleDemobilizedIllness.class);
					if("7".equals(changeStateSuf)){//去世
						b.setCancellationDate((String)record.get("deathDate"));
					}else if("8".equals(changeStateSuf)){//取消
						b.setCancellationDate(bptStateChange.getChangeStateDate());
					}
					demobilizedIllnessService.updateBptPeopleDemobilizedIllness(b);
				}
			}else if("5".equals(objectType.substring(0,1))){
				DataSet ds =iWarService.query(pset);
				if(ds.getCount()>0){
					BptPeopleWar b =(BptPeopleWar)ds.getRecord(0).toBean(BptPeopleWar.class);
					if("7".equals(changeStateSuf)){//去世
						b.setCancellationDate((String)record.get("deathDate"));
					}else if("8".equals(changeStateSuf)){//取消
						b.setCancellationDate(bptStateChange.getChangeStateDate());
					}
					iWarService.updateWar(b);
				}
			}else if("6".equals(objectType.substring(0,1))){
				DataSet ds =iBptPeopleTestedService.queryPeopleTested(pset);
				if(ds.getCount()>0){
					BptPeopleTested b =(BptPeopleTested)ds.getRecord(0).toBean(BptPeopleTested.class);
					if("7".equals(changeStateSuf)){//去世
						b.setCancellationDate((String)record.get("deathDate"));
					}else if("8".equals(changeStateSuf)){//取消
						b.setCancellationDate(bptStateChange.getChangeStateDate());
					}
					iBptPeopleTestedService.updatePeopleTeseted(b);
				}
			}else if("8".equals(objectType.substring(0,1))){
				DataSet ds =ptCountRetiredSoldierDao.query(pset);
				if(ds.getCount()>0){
					BptCountRetiredSoldier b =(BptCountRetiredSoldier)ds.getRecord(0).toBean(BptCountRetiredSoldier.class);
					if("7".equals(changeStateSuf)){//去世
						b.setCancellationDate((String)record.get("deathDate"));
					}else if("8".equals(changeStateSuf)){//取消
						b.setCancellationDate(bptStateChange.getChangeStateDate());
					}
					ptCountRetiredSoldierDao.update(b);
				}
			}else if("B".equals(objectType.substring(0,1))){
				DataSet ds =martyrOffspringDomain.query(pset);
				if(ds.getCount()>0){
					BptPeopleMartyrOffspring b =(BptPeopleMartyrOffspring)ds.getRecord(0).toBean(BptPeopleMartyrOffspring.class);
					if("7".equals(changeStateSuf)){//去世
						b.setCancellationDate((String)record.get("deathDate"));
					}else if("8".equals(changeStateSuf)){//取消
						b.setCancellationDate(bptStateChange.getChangeStateDate());
					}
					martyrOffspringDomain.update(b);
				}
			}
		
	}
	/**
	 * 获取状态变更信息
	 */
	private BptStateChange getBptStateChange(){
		Record record = (Record) getParameter("StateChangeRecord");
		String changeStatePre = (String)getParameter("changeStatePre");
		BptStateChange dataBean=(BptStateChange)record.toBean(BptStateChange.class);
		dataBean.setStateChangeId(IdHelp.getUUID30());
		dataBean.setChangeStatePre(changeStatePre);
		dataBean.setChangeStateDate(DateUtil.getDay());
		dataBean.setRegId(BspUtil.getEmpOrganId());
		dataBean.setRegTime(DateUtil.getTime());
		dataBean.setModId(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		return dataBean;
	}
	
	/**
	 * 获取状态变更修改后的信息
	 */
	private BptStateChange getUpdateBptStateChange(){
		Record record = (Record) getParameter("StateChangeRecord");
		String changeStatePre = (String)getParameter("changeStatePre");
		String objectType = (String) getParameter("objectType");
		BptStateChange dataBean=(BptStateChange)record.toBean(BptStateChange.class);
//		dataBean.setStateChangeId(IdHelp.getUUID30());
		dataBean.setStateChangeId((String)getParameter("stateChangeId"));
		dataBean.setObjectType(objectType);
		dataBean.setChangeStatePre(changeStatePre);
		dataBean.setChangeStateDate(DateUtil.getDay());
		dataBean.setRegId(BspUtil.getEmpOrganId());
		dataBean.setRegTime(DateUtil.getTime());
		dataBean.setModId(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		return dataBean;
	}

	/**
	 * 获取人员信息
	 */
	private BaseinfoPeople getBaseinfoPeople(){
		Record stateChangeRecord = (Record) getParameter("StateChangeRecord");
		String objectType = (String)getParameter("objectType");
		String changeState = (String)stateChangeRecord.get("changeStateSuf");
		ParameterSet pset = getParameterSet();
		pset.remove("StateChangeRecord");
		pset.remove("changeStatePre");
		pset.remove("objectType");
		pset.setParameter("BASEINFO_PEOPLE.PEOPLE_ID@=", stateChangeRecord.get("peopleId").toString());
		DataSet peopleDataSet = service.queryPeople(pset);
		Record peopleRecord = peopleDataSet.getRecord(0);
		BaseinfoPeople bean = (BaseinfoPeople) peopleRecord.toBean(BaseinfoPeople.class);
		if("11".equals(objectType)||"12".equals(objectType)||"13".equals(objectType)||"14".equals(objectType)||"15".equals(objectType)){
			bean.setDisabilityStateCode(changeState);
		}else if("21".equals(objectType)||"22".equals(objectType)||"23".equals(objectType)){
			bean.setDependantStateCode(changeState);
		}else if("31".equals(objectType)||"32".equals(objectType)||"33".equals(objectType)){
			bean.setRedaStateCode(changeState);
		}else if("41".equals(objectType)||"42".equals(objectType)){
			bean.setDemobilizedStateCode(changeState);
		}else if("51".equals(objectType)||"61".equals(objectType)){
			bean.setWarStateCode(changeState);
		}else if("81".equals(objectType)){
			bean.setRetiredStateCode(changeState);
		}else if("B1".equals(objectType)){
			bean.setMartyrOffspringStateCode(changeState);
		}
		return bean;
	}
	
	/**
	 * 根据前台传过来的peopleId查询人员的name和idCard信息
	 * @return
	 */
	public void queryPeopleInfo(){
		ParameterSet pset = getParameterSet();
		String peopleId = (String)pset.getParameter("peopleId");
		pset.setParameter("PEOPLE_ID@=", peopleId);
		pset.remove("peopleId");
		DataSet ds =  service.queryPeople(pset);
		Record rd = ds.getRecord(0);
		String name = (String)rd.get("name");
		String idCard = (String)rd.get("idCard");
		this.setReturn("name", name);
		this.setReturn("idCard", idCard);
		
	
		StringBuffer objectType= new StringBuffer();
		StringBuffer objectTypeCode= new StringBuffer();
		DataSet bds = service.queryBptPeople(pset);
		for(int i=0;i<bds.getCount();i++){
			String dy=(String)bds.getRecord(i).get("disabilityTypeCode");
			String dt=(String)bds.getRecord(i).get("depandantTypeCode");
			String dd=(String)bds.getRecord(i).get("demobilizedTypeCode");
			String wr=(String)bds.getRecord(i).get("warTypeCode");
			String ra=(String)bds.getRecord(i).get("redaTypeCode");
			List<String> list = new ArrayList<String>();
			if(!("00".equals(dy)||dy==null)){
				list.add(dy);
				objectTypeCode.append(dy);
			}
			if(!("00".equals(dt)||dt==null)){
				list.add(dt);
				objectTypeCode.append(dt);
			}
			if(!("00".equals(dd)||dd==null)){
				list.add(dd);
				objectTypeCode.append(dd);
			}
			if(!("00".equals(wr)||wr==null)){
				list.add(wr);
				objectTypeCode.append(wr);
			}
			if(!("00".equals(ra)||ra==null)){
				list.add(ra);
				objectTypeCode.append(ra);
			}
			for (String s : list) {
				if("11".endsWith(s)){
					objectType.append("残疾军人");
				}else if("12".endsWith(s)){
					objectType.append("伤残国家机关工作人员");
				}else if("13".endsWith(s)){
					objectType.append("伤残人民警察");
				}else if("14".endsWith(s)){
					objectType.append("伤残民兵民工");
				}else if("15".endsWith(s)){
					objectType.append("因战因公伤残人员");
				}else if("21".endsWith(s)){
					objectType.append("烈士家属");
				}else if("22".endsWith(s)){
					objectType.append("因公牺牲军人家属");
				}else if("23".endsWith(s)){
					objectType.append("病故军人家属");
				}else if("31".endsWith(s)){
					objectType.append("在乡退伍红军老战士");
				}else if("32".endsWith(s)){
					objectType.append("在乡西路军红军老战士");
				}else if("33".endsWith(s)){
					objectType.append("红军失散人员");
				}else if("41".endsWith(s)){
					objectType.append("在乡复员军人");
				}else if("42".endsWith(s)){
					objectType.append("带病回乡复员军人");
				}else if("51".endsWith(s)){
					objectType.append("参战");
				}else if("61".endsWith(s)){
					objectType.append("参试");
				}else if("81".endsWith(s)){
					objectType.append("60周岁以上农村籍退役士兵");
				}else if("B1".endsWith(s)){
					objectType.append("部分烈士（错杀被平反人员）子女");
				}
			}
		}
		
		this.setReturn("objectTypeContext", objectType.toString());
		this.setReturn("objectType", objectTypeCode.toString());
	}
	
}
