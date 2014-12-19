package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;
import org.loushang.workflow.api.WfTaskRequestWrapper;

import com.inspur.cams.bpt.base.dao.IBptApplyMartyrOffspringDao;
import com.inspur.cams.bpt.base.dao.IBptPeopleDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao;
import com.inspur.cams.bpt.base.data.BptApplyDependant;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.base.domain.IBptApplyDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyEmigrationDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyMartyrOffspringDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IBptProvinceMigrateDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.DateUtil;

/**
 * 三属申请command
 * 
 * @author zhanghui
 * 
 */
public class BptDelPeopleCommand extends BaseAjaxCommand {

	/**
	 * 伤残审批服务接口
	 */
	IBptApplyDisabilityDomain applyDisabilityService = ScaComponentFactory
			.getService(IBptApplyDisabilityDomain.class,
					"bptApplyDisabilityDomain/bptApplyDisabilityDomain");
	/**
	 * 三属人员申请接口
	 */
	private IBptApplyDependantDomain bptApplyService = ScaComponentFactory
			.getService(IBptApplyDependantDomain.class,
					"bptApplyDependantDomain/bptApplyDependantDomain");
	/**
	 * 获得在乡复员审批服务接口
	 */
	IBptApplyDemobilizedDomain bptApplyDemobilizedService = ScaComponentFactory.getService(IBptApplyDemobilizedDomain.class,
	"bptApplyDemobilizedDomain/bptApplyDemobilizedDomain");
	
	IBptApplyMartyrOffspringDao dao = (IBptApplyMartyrOffspringDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptApplyMartyrOffspringDao");
	
	IBptApplyMartyrOffspringDomain applyMartyrOffspringDomain = (IBptApplyMartyrOffspringDomain)ScaComponentFactory.getService(IBptApplyMartyrOffspringDomain.class,
				"bptApplyMartyrOffspringDomain/bptApplyMartyrOffspringDomain");
	
	/**
	 * 获得【外省优抚人员抚恤关系迁入我省】服务接口
	 */
	private IBptApplyIntoprovinceDomain bptApplyIntoprovinceService = ScaComponentFactory
			.getService(IBptApplyIntoprovinceDomain.class,
					"BptApplyIntoprovinceDomain/BptApplyIntoprovinceDomain");
	
	IBptApplyEmigrationDomain bptApplyEmigrationService = ScaComponentFactory
	.getService(IBptApplyEmigrationDomain.class,
			"BptApplyEmigrationDomain/BptApplyEmigrationDomain");
	
	IBptProvinceMigrateDomain bptProvinceMigratService = ScaComponentFactory
	.getService(IBptProvinceMigrateDomain.class,
			"BptProvinceMigrateDomain/BptProvinceMigrateDomain");
	
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	
	/**
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory.getService(IBptApplyHistoryDomain.class,
	"BptApplyHistoryDomain/BptApplyHistoryDomain");
	
	BptElectronicDao electronicdao = (BptElectronicDao) DaoFactory
	.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao");
	
	@Trans
	public void delete(){
		Record[] records = (Record[]) getParameter("record");
		List<String> applyIds = new ArrayList<String>();
		String serviceType = "";
		String peopleId="";
		String applyId="";
		String objectType="";
		for (Record record : records) {
			peopleId =(String)record.get("PEOPLE_ID");
			applyId =(String)record.get("APPLY_ID");
			serviceType =(String)record.get("SERVICE_TYPE");
			objectType =(String)record.get("OBJECT_TYPE");
			ParameterSet pset = new ParameterSet();
			pset.setParameter("applyId", applyId);
			pset.setParameter("peopleId", peopleId);
			if("15".equals(serviceType)||"22".equals(serviceType)||"42".equals(serviceType)
					||"46".equals(serviceType)||"52".equals(serviceType)||"62".equals(serviceType)
					||"82".equals(serviceType)||"B2".equals(serviceType)){//申请迁入
				pset.remove("peopleId");
				pset.setParameter("applyId", applyId);
				bptApplyIntoprovinceService.deleteIntoprovince(pset);
			}else if("11".equals(serviceType)||"12".equals(serviceType)||"13".equals(serviceType)
					||"14".equals(serviceType)||"17".equals(serviceType)||"1".equals(objectType.substring(0, 1))){//申请伤残
				String disType = "";
				if("11".equals(serviceType)){
					disType="assess";
				}else if("12".equals(serviceType)){
					disType="adjust";
				}else if("13".equals(serviceType)){
					disType="exchange";
				}else if("14".equals(serviceType)){
					disType="veterans";
				}else if("17".equals(serviceType)){
					disType="assistive";
				}
				if("1".equals(objectType.substring(0, 1))&&("".equals(applyId)||applyId==null)){//删除非申请人员
					disType="assess";
				}
				pset.setParameter("disType", disType);
				applyDisabilityService.deleteAboutDisability(pset);
			}else if("21".equals(serviceType)||"21".equals(objectType)
					||"22".equals(objectType)||"23".equals(objectType)){//三属申请
				bptApplyService.deleteDependant(pset);
			}else if("51".equals(serviceType)||"61".equals(serviceType)
					||"51".equals(objectType)||"61".equals(objectType)){//cz cs
				String warOrTest = "";
				if("51".equals(serviceType)||"51".equals(objectType)){
					warOrTest = "war";
				}else if ("61".equals(serviceType)||"61".equals(objectType)){
					warOrTest = "test";
				}
				pset.setParameter("warOrTest", warOrTest);
				bptApplyService.deleteDependant(pset);
			}else if("41".equals(serviceType)||"41".equals(objectType)){//申请 zx db
				bptApplyDemobilizedService.deleteDemobilized(pset);
			}else if ("45".equals(serviceType)||"42".equals(objectType)){
				bptApplyDemobilizedService.deleteDemobilizedIll(pset);
			}else if("19".equals(serviceType)||"25".equals(serviceType)||"4B".equals(serviceType)
					||"4A".equals(serviceType)||"55".equals(serviceType)||"65".equals(serviceType)
					||"84".equals(serviceType)||"B4".equals(serviceType)){//申请迁出
				pset.remove("peopleId");
				pset.setParameter("applyId", applyId);
				bptApplyEmigrationService.deleteEmigration(pset);
			}else if("16".equals(serviceType)||"23".equals(serviceType)||"43".equals(serviceType)
					||"47".equals(serviceType)||"53".equals(serviceType)||"63".equals(serviceType)
					||"83".equals(serviceType)||"B3".equals(serviceType)){//申请省内迁移 
				pset.remove("peopleId");
				pset.setParameter("applyId", applyId);
				bptProvinceMigratService.deleteProvinceMigrate(pset);
			}else if("81".equals(serviceType)||"81".equals(objectType)){ //60退役士兵
				dao.deleteCountrySoldier(pset);
			}else if ("B1".equals(serviceType)||"B1".equals(objectType)){//申请 烈属子女，
				applyMartyrOffspringDomain.deleteMartyrOffspring(pset);
			}else if("A1".equals(serviceType)){//申请 临时
				applyIds.add(applyId);
			}
			bptApplyHistoryService.delHistoryByApplyId(pset);
			electronicdao.delElectByApplyId(pset);
		}
		if("A1".equals(serviceType)){//申请 临时
			service.deleteTemporaryHelp((String[])applyIds.toArray());
		}
		
	}
	public void deletePeople(){
		IBptPeopleDao  bptPeopleDao = (IBptPeopleDao) DaoFactory
		        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDao");
		Record[] records = (Record[]) getParameter("record");
		List<String> applyIds = new ArrayList<String>();
		String peopleId="";
		for (Record record : records) {
			peopleId =(String)record.get("PEOPLE_ID");
			ParameterSet pset = new ParameterSet();
			pset.setParameter("peopleId", peopleId);
			bptPeopleDao.deletePeopele(pset);
		}
		
	}
	
}
