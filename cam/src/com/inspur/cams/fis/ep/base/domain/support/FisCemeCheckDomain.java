package com.inspur.cams.fis.ep.base.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.ep.base.dao.IFisCemeAccessoriesDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckAuditDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckInfoDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckResultDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckScoreDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckWfDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeDao;
import com.inspur.cams.fis.ep.base.data.FisCemeAccessories;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckInfo;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckScore;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckWf;
import com.inspur.cams.fis.ep.base.domain.IFisCemeCheckDomain;

/**
 * @title: FisCemeCheckDomain
 * @description:公墓年检表单domain
 * @version:1.0
 */
public class FisCemeCheckDomain implements IFisCemeCheckDomain {

	private IFisCemeCheckWfDao fisCemeCheckWfDao;
	
	private IFisCemeCheckInfoDao fisCemeCheckInfoDao;

	private IFisCemeCheckResultDao fisCemeCheckResultDao;

	private IFisCemeAccessoriesDao fisCemeAccessoriesDao;

	private IFisCemeCheckAuditDao fisCemeCheckAuditDao;

	private IFisCemeCheckScoreDao fisCemeCheckScoreDao;

	private IFisCemeDao fisCemeDao;

	public DataSet query(ParameterSet pset) {
		String id = (String) pset.getParameter("CEME_ID");
		if ((id != null) && (!"null".equals(id))) {
			DataSet ds = fisCemeDao.query(pset);
			return ds;
		}
		DataSet ds = fisCemeCheckInfoDao.query(pset);
		return ds;
	}

	public FisCemeCheckResult getResult(String resultId) {
		return fisCemeCheckResultDao.get(resultId);
	}

	public void updateResult(FisCemeCheckResult result) {
		fisCemeCheckResultDao.update(result);
	}

	public void insert(FisCemeCheckResult result) {
		fisCemeCheckResultDao.insert(result);
	}

	public DataSet queryAccessories(ParameterSet pset) {
		return fisCemeAccessoriesDao.queryAccessories(pset);
	}

	public DataSet queryScore(ParameterSet pset) {
		return fisCemeCheckScoreDao.query(pset);
	}

	public void uploadSave(List<FisCemeAccessories> list) {
		fisCemeAccessoriesDao.batchInsert(list);
	}

	public DataSet queryAccessoriesItem(ParameterSet pset) {
		return fisCemeAccessoriesDao.queryAccessoriesItem(pset);
	}

	public void delAccessoriesById(String id) {
		fisCemeAccessoriesDao.delete(id);
	}

	public void updateInfo(FisCemeCheckInfo info) {
		fisCemeCheckInfoDao.update(info);
	}

	public void updateAudit(FisCemeCheckAudit audit) {
		fisCemeCheckAuditDao.update(audit);
	}

	public void save(FisCemeCheckInfo info, FisCemeCheckAudit audit,
			FisCemeCheckScore score) {
		fisCemeCheckInfoDao.insert(info);
		fisCemeCheckAuditDao.insert(audit);
		fisCemeCheckScoreDao.insert(score);
	}

	public DataSet queryAudit(ParameterSet pset) {
		return fisCemeCheckAuditDao.query(pset);
	}

	@Reference
	public void setFisCemeCheckInfoDao(IFisCemeCheckInfoDao fisCemeCheckInfoDao) {
		this.fisCemeCheckInfoDao = fisCemeCheckInfoDao;
	}

	@Reference
	public void setFisCemeCheckResultDao(
			IFisCemeCheckResultDao fisCemeCheckResultDao) {
		this.fisCemeCheckResultDao = fisCemeCheckResultDao;
	}

	@Reference
	public void setFisCemeAccessoriesDao(
			IFisCemeAccessoriesDao fisCemeAccessoriesDao) {
		this.fisCemeAccessoriesDao = fisCemeAccessoriesDao;
	}

	@Reference
	public void setFisCemeCheckAuditDao(
			IFisCemeCheckAuditDao fisCemeCheckAuditDao) {
		this.fisCemeCheckAuditDao = fisCemeCheckAuditDao;
	}

	@Reference
	public void setFisCemeCheckScoreDao(
			IFisCemeCheckScoreDao fisCemeCheckScoreDao) {
		this.fisCemeCheckScoreDao = fisCemeCheckScoreDao;
	}

	@Reference
	public void setFisCemeDao(IFisCemeDao fisCemeDao) {
		this.fisCemeDao = fisCemeDao;
	}

	@Reference
	public void setFisCemeCheckWfDao(IFisCemeCheckWfDao fisCemeCheckWfDao) {
		this.fisCemeCheckWfDao = fisCemeCheckWfDao;
	}

	public DataSet queryForCemeInfo(ParameterSet pset) {
		return fisCemeCheckInfoDao.queryForCemeInfo(pset);
	}
	
	//插入公益性公墓年检信息 (县级年检)
	public void insertNoProfitCheck(FisCemeCheckWf wf) {
		fisCemeCheckWfDao.insert(wf);
		fisCemeCheckInfoDao.insert(wf.getFisCemeCheckInfo());
		fisCemeCheckAuditDao.insert(wf.getFisCemeCheckAudit());
		fisCemeCheckScoreDao.insert(wf.getFisCemeCheckScore());
		fisCemeCheckResultDao.insert(wf.getFisCemeCheckResult());
	}

	//更新公益性公墓年检信息 (县级年检)
	public void updateNoProfitCheck(FisCemeCheckWf wf, boolean isUpdate) {
		fisCemeCheckWfDao.update(wf);
		fisCemeCheckResultDao.update(wf.getFisCemeCheckResult());
		
		if (isUpdate) {
			fisCemeCheckInfoDao.update(wf.getFisCemeCheckInfo());
			fisCemeCheckAuditDao.update(wf.getFisCemeCheckAudit());
			fisCemeCheckScoreDao.update(wf.getFisCemeCheckScore());
		} else {
			fisCemeCheckInfoDao.insert(wf.getFisCemeCheckInfo());
			fisCemeCheckAuditDao.insert(wf.getFisCemeCheckAudit());
			fisCemeCheckScoreDao.insert(wf.getFisCemeCheckScore());
		}
	}
	
	//插入经营性公墓检查信息 (县级检查)
	public void insertProfitCheck(FisCemeCheckWf wf) {
		fisCemeCheckWfDao.insert(wf);
		fisCemeCheckInfoDao.insert(wf.getFisCemeCheckInfo());
		fisCemeCheckAuditDao.insert(wf.getFisCemeCheckAudit());
		fisCemeCheckScoreDao.insert(wf.getFisCemeCheckScore());
		fisCemeCheckResultDao.insert(wf.getFisCemeCheckResult());
	}
	
	//更新经营性公墓检查信息 (县级检查、市级年检)
	public void updateProfitCheck(FisCemeCheckWf wf, boolean isUpdate) {
		fisCemeCheckWfDao.update(wf);
		fisCemeCheckResultDao.update(wf.getFisCemeCheckResult());
		
		if (isUpdate) {
			fisCemeCheckInfoDao.update(wf.getFisCemeCheckInfo());
			fisCemeCheckAuditDao.update(wf.getFisCemeCheckAudit());
			fisCemeCheckScoreDao.update(wf.getFisCemeCheckScore());
		} else {
			fisCemeCheckInfoDao.insert(wf.getFisCemeCheckInfo());
			fisCemeCheckAuditDao.insert(wf.getFisCemeCheckAudit());
			fisCemeCheckScoreDao.insert(wf.getFisCemeCheckScore());
		}
	}
	
	//上报公益性公墓年检信息 (县级年检)
	public void reportNoProfitCheck(ParameterSet pset) {
		DataSet ds = fisCemeCheckWfDao.query(pset);
		if(ds.getCount() > 0) {
			String endApplyId = (String)ds.getRecord(0).get("endApplyId");
			String wfId = (String)ds.getRecord(0).get("wfId");
			String checkResult = (String)ds.getRecord(0).get("checkResult");
			fisCemeCheckWfDao.reportNoProfitCheck(wfId);
			fisCemeCheckResultDao.reportNoProfitCheck(wfId,checkResult);
			fisCemeCheckInfoDao.reportNoProfitCheck(endApplyId);
		}
	}
	
	//整改公益性公墓年检信息 (县级年检)
	public void fullChangeNoProfitCheck(ParameterSet pset) {
		DataSet ds = fisCemeCheckWfDao.query(pset);
		if(ds.getCount() > 0) {
			String endApplyId = (String)ds.getRecord(0).get("endApplyId");
			String wfId = (String)ds.getRecord(0).get("wfId");
			fisCemeCheckWfDao.fullChangeNoProfitCheck(wfId);
			fisCemeCheckResultDao.fullChangeNoProfitCheck(wfId);
		}
	}
	
	//上报经营性公墓年检信息 (县级检查)
	public void reportProfitCheck(ParameterSet pset) {
		DataSet ds = fisCemeCheckWfDao.query(pset);
		if(ds.getCount() > 0) {
			String endApplyId = (String)ds.getRecord(0).get("endApplyId");
			String wfId = (String)ds.getRecord(0).get("wfId");
			fisCemeCheckWfDao.reportProfitCheck(wfId);
//			fisCemeCheckResultDao.reportProfitCheck(wfId,null);//县级检查不需要更新结果表
			fisCemeCheckInfoDao.reportProfitCheck(endApplyId);
		}
		
	}
	
	//上报经营性公墓年检信息 (市级年检)
	public void reportProfitFinalCheck(ParameterSet pset) {
		DataSet ds = fisCemeCheckWfDao.query(pset);
		if(ds.getCount() > 0) {
			String endApplyId = (String)ds.getRecord(0).get("endApplyId");
			String wfId = (String)ds.getRecord(0).get("wfId");
			String checkResult = (String)ds.getRecord(0).get("checkResult");
			fisCemeCheckWfDao.reportProfitFinalCheck(wfId);
			fisCemeCheckResultDao.reportProfitFinalCheck(wfId,checkResult);
			fisCemeCheckInfoDao.reportProfitFinalCheck(endApplyId);
		}
	}
	
	//整改经营性公墓年检信息 (市级年检)
	public void fullChangeProfitFinalCheck(ParameterSet pset) {
		DataSet ds = fisCemeCheckWfDao.query(pset);
		if(ds.getCount() > 0) {
			String endApplyId = (String)ds.getRecord(0).get("endApplyId");
			String wfId = (String)ds.getRecord(0).get("wfId");
			fisCemeCheckWfDao.fullChangeProfitFinalCheck(wfId);
			fisCemeCheckResultDao.fullChangeProfitFinalCheck(wfId);
		}
	}
	
	public String queryPrint(ParameterSet pset) {
		StringBuffer str = new StringBuffer();
		DataSet ds = fisCemeCheckInfoDao.query(pset);
			Record record = ds.getRecord(0);
			str.append(record.get("cemeName")+ "$$");
			str.append(record.get("manaLevel")+ "$$");
			str.append(record.get("organizer")+ "$$");
			str.append(record.get("cemeId")+ "$$");
			str.append(record.get("legalPerson")+ "$$");
			str.append(record.get("prop")+ "$$");
			str.append(record.get("directorMobile")+ "$$");
			str.append(record.get("gestionTime")+ "$$");
			str.append(record.get("totalArea")+ "$$");
			//str.append(record.get("fundSources")+ "$$");
			str.append(record.get("areaLevel")+ "$$");
			str.append(record.get("address")+ "$$");
			//str.append(record.get("serviceScope")+ "$$");
			
			str.append(record.get("yearPeopleNum")+ "$$");
			str.append(record.get("sincePeopleNum")+ "$$");
			str.append(record.get("yearSingleHole")+ "$$");
			str.append(record.get("yearDoubleHole")+ "$$");
			str.append(record.get("yearMoreHole")+ "$$");
			str.append(record.get("yearHoleNum")+ "$$");
			str.append(record.get("outSingleHole")+ "$$");
			str.append(record.get("outDoubleHole")+ "$$");
			str.append(record.get("outMoreHole")+ "$$");
			str.append(record.get("yearOutNum")+ "$$");
			str.append(record.get("singleHole")+ "$$");
			str.append(record.get("doubleHole")+ "$$");
			str.append(record.get("moreHole")+ "$$");
			str.append(record.get("sinceHoleNum")+ "$$");
		
		DataSet ds2 = fisCemeCheckScoreDao.query(pset);
			Record record2 = ds2.getRecord(0);
			str.append(record2.get("businesscertificateScore")+ "$$");//县级民政部门批准建设文件得分
			str.append(ifNull(record2.get("businesscertificateReason"))+ "$$");//县级民政部门批准建设文件扣分加分原因
			str.append(record2.get("businesslicenseScore")+ "$$");//本公益性公墓管理章程得分
			str.append(ifNull(record2.get("businesslicenseReason"))+ "$$");//本公益性公墓管理章程原因
			str.append(record2.get("purchasegravesScore")+ "$$");//安葬（安放）墓穴（格位）的条件和程序得分
			str.append(ifNull(record2.get("purchasegravesReason"))+ "$$");//安葬（安放）墓穴（格位）的条件和程序原因
			str.append(record2.get("feeScore")+ "$$");//收费项目、收费标准、收费依据等价格公示内容得分
			str.append(ifNull(record2.get("feeReason"))+ "$$");//收费项目、收费标准、收费依据等价格公示内容原因
			str.append(record2.get("pledgeScore")+ "$$");//服务承诺得分
			str.append(ifNull(record2.get("pledgeReason"))+ "$$");//服务承诺原因
			str.append(record2.get("staffresponsibilitiesScore")+ "$$");//工作人员职责及照片、编号得分
			str.append(ifNull(record2.get("staffresponsibilitiesReason"))+ "$$");//工作人员职责及照片、编号原因
			str.append(record2.get("officeTimeScore")+ "$$");//服务时间、地点、电话和监督电话得分
			str.append(ifNull(record2.get("officeTimeReason"))+ "$$");//服务时间、地点、电话和监督电话原因
			str.append(record2.get("boxesandbagsScore")+ "$$");//使用全省统一的卷盒和卷袋得分
			str.append(ifNull(record2.get("boxesandbagsReason"))+ "$$");//使用全省统一的卷盒和卷袋原因
			str.append(record2.get("deathcertificateScore")+ "$$");//有死亡证明或火化证明的复印件得分
			str.append(ifNull(record2.get("deathcertificateReason"))+ "$$");//有死亡证明或火化证明的复印件原因
			str.append(record2.get("propergraveScore")+ "$$");//有骨灰安放（葬）协议、补充签订的协议得分
			str.append(ifNull(record2.get("propergraveReason"))+ "$$");//有骨灰安放（葬）协议、补充签订的协议原因
			str.append(record2.get("ashescontractScore")+ "$$");//有丧事承办人签名的骨灰安放（葬）处理表得分
			str.append(ifNull(record2.get("ashescontractReason"))+ "$$");//有丧事承办人签名的骨灰安放（葬）处理表原因
			str.append(record2.get("contractoridScore")+ "$$");//有丧事承办人的有效身份证件复印件得分
			str.append(ifNull(record2.get("contractoridReason"))+ "$$");//有丧事承办人的有效身份证件复印件原因
			str.append(record2.get("othermaterialsScore")+ "$$");//有其他应当归档的材料得分
			str.append(ifNull(record2.get("othermaterialsReason"))+ "$$");//有其他应当归档的材料原因
			str.append(record2.get("tombstoneTwentyNum")+ "$$");//墓穴面积或墓碑高度超过规定标准20%以下的个数
			str.append(record2.get("tombstoneTwentyScore")+ "$$");//墓穴面积或墓碑高度超过规定标准20%以下的个数得分
			str.append(ifNull(record2.get("tombstoneTwentyReason"))+ "$$");//墓穴面积或墓碑高度超过规定标准20%以下的个数原因
			str.append(record2.get("tombstoneFiftyNum")+ "$$");//墓穴面积或墓碑高度超过规定标准20%至50%的个数
			str.append(record2.get("tombstoneFiftyScore")+ "$$");//墓穴面积或墓碑高度超过规定标准20%至50%的个数得分
			str.append(ifNull(record2.get("tombstoneFiftyReason"))+ "$$");//墓穴面积或墓碑高度超过规定标准20%至50%的个数原因
			str.append(record2.get("tombstoneoverfiftyNum")+ "$$");//墓穴面积或墓碑高度超过规定标准50%以上的个数
			str.append(record2.get("tombstoneoverfiftyScore")+ "$$");//墓穴面积或墓碑高度超过规定标准50%以上的个数得分
			str.append(ifNull(record2.get("tombstoneoverfiftyReason"))+ "$$");//墓穴面积或墓碑高度超过规定标准50%以上的个数原因
			str.append(record2.get("roadsafetyScore")+ "$$");//道路畅通，安全防护措施到位得分
			str.append(ifNull(record2.get("roadsafetyReason"))+ "$$");//道路畅通，安全防护措施到位原因
			str.append(record2.get("civilizationMemorialScore")+ "$$");//有文明祭奠举措，无封建迷信活动得分
			str.append(ifNull(record2.get("civilizationMemorialReason"))+ "$$");//有文明祭奠举措，无封建迷信活动原因
			str.append(record2.get("fireMemorialScore")+ "$$");//允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批得分
			str.append(ifNull(record2.get("fireMemorialReason"))+ "$$");//允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批原因
			str.append(record2.get("ecologyScore")+ "$$");//生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例得分
			str.append(ifNull(record2.get("ecologyReason"))+ "$$");//生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例原因
			str.append(record2.get("greenCoverageNum")+ "$$");//绿化覆盖率
			str.append(record2.get("greenCoverageScore")+ "$$");//绿化覆盖率得分
			str.append(ifNull(record2.get("greenCoverageReason"))+ "$$");//绿化覆盖率原因
			str.append(record2.get("greenareaRatioNum")+ "$$");//绿地面积和占总面积的比例
			str.append(record2.get("greenareaRatioScore")+ "$$");//绿地面积和占总面积的比例得分
			str.append(ifNull(record2.get("greenareaRatioReason"))+ "$$");//绿地面积和占总面积的比例原因
			str.append(record2.get("burialTombScore")+ "$$");//按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）得分
			str.append(ifNull(record2.get("burialTombReason"))+ "$$");//按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）原因
			str.append(record2.get("burialConformScore")+ "$$");//墓区建设地点和规模与申报材料相符得分
			str.append(ifNull(record2.get("burialConformReason"))+ "$$");//墓区建设地点和规模与申报材料相符原因
			str.append(record2.get("nooffenseScore")+ "$$");//无违法出租或买卖墓穴（格位）现象得分
			str.append(ifNull(record2.get("nooffenseReason"))+ "$$");//无违法出租或买卖墓穴（格位）现象原因
			str.append(record2.get("acceptanceComplianceScore")+ "$$");//新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定得分
			str.append(ifNull(record2.get("acceptanceComplianceReason"))+ "$$");//新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定原因
			str.append(record2.get("changeComplianceScore")+ "$$");//公墓更名符合《山东省公墓管理办法》规定得分
			str.append(ifNull(record2.get("changeComplianceReason"))+ "$$");//公墓更名符合《山东省公墓管理办法》规定原因
			str.append(record2.get("agenciesScore")+ "$$");//墓区管理机构的组建与申报报告相符得分
			str.append(ifNull(record2.get("agenciesReason"))+ "$$");//墓区管理机构的组建与申报报告相符原因
			str.append(record2.get("businessTrainingScore")+ "$$");//工作人员参加省或设区的市人民政府民政部门组织的业务培训得分
			str.append(ifNull(record2.get("businessTrainingReason"))+ "$$");//工作人员参加省或设区的市人民政府民政部门组织的业务培训原因
			str.append(record2.get("systemSoundScore")+ "$$");//公墓管理的各项规章制度健全得分
			str.append(ifNull(record2.get("systemSoundReason"))+ "$$");//公墓管理的各项规章制度健全原因
			str.append(record2.get("contingencyPlansScore")+ "$$");//有高峰应急预案得分
			str.append(ifNull(record2.get("contingencyPlansReason"))+ "$$");//有高峰应急预案原因
			str.append(record2.get("ecologyNum")+ "$$");//生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例
			
			DataSet ds3 = fisCemeCheckAuditDao.query(pset);
			Record record3 = ds3.getRecord(0);
			str.append(record3.get("totalScore")+ "$$");//年检总得分
			str.append(record3.get("annuareport")+ "$$");//年检报告
			
		return str.toString();
	}
	
	public Object ifNull(Object value){
		Object result =null;
		if(value==null){
			result="";
		}else{
			result=value;
		}
		return result;
	}
	
	public String queryJYPrint(ParameterSet pset) {
		StringBuffer str = new StringBuffer();
		DataSet ds = fisCemeCheckInfoDao.query(pset);
			Record record = ds.getRecord(0);
			
			str.append(record.get("cemeName")+ "$$");
			str.append(record.get("manaLevel")+ "$$");
			str.append(record.get("unitProperties")+ "$$");
			str.append(record.get("cemeId")+ "$$");
			str.append(record.get("organizer")+ "$$");
			str.append(record.get("prop")+ "$$");
			str.append(record.get("legalPerson")+ "$$");
			str.append(record.get("totalStaff")+ "$$");
			str.append(record.get("directorMobile")+ "$$");
			str.append(record.get("officePhone")+ "$$");
			str.append(record.get("fixeDassets")+ "$$");
			str.append(record.get("totalInvestment")+ "$$");
			str.append(record.get("gestionTime")+ "$$");
			str.append(record.get("postalcode")+ "$$");
			str.append(record.get("totalArea")+ "$$");
			str.append(record.get("builtArea")+ "$$");
			str.append(record.get("builtTotalArea")+ "$$");
			str.append(record.get("areaLevel")+ "$$");
			str.append(record.get("address")+ "$$");
			
			str.append(record.get("yearPeopleNum")+ "$$");
			str.append(record.get("sincePeopleNum")+ "$$");
			str.append(record.get("sellSingleHole")+ "$$");
			str.append(record.get("sellDoubleHole")+ "$$");
			str.append(record.get("sellMoreHole")+ "$$");
			str.append(record.get("yearSellNum")+ "$$");
			str.append(record.get("yearSingleHole")+ "$$");
			str.append(record.get("yearDoubleHole")+ "$$");
			str.append(record.get("yearMoreHole")+ "$$");
			str.append(record.get("yearHoleNum")+ "$$");
			str.append(record.get("outSingleHole")+ "$$");
			str.append(record.get("outDoubleHole")+ "$$");
			str.append(record.get("outMoreHole")+ "$$");
			str.append(record.get("yearOutNum")+ "$$");
			str.append(record.get("singleHole")+ "$$");
			str.append(record.get("doubleHole")+ "$$");
			str.append(record.get("moreHole")+ "$$");
			str.append(record.get("sinceHoleNum")+ "$$");
			str.append(ifNull(record.get("notReasons"))+ "$$");
			
		DataSet ds2 = fisCemeCheckScoreDao.query(pset);
			Record record2 = ds2.getRecord(0);
			str.append(record2.get("businesscertificateScore")+ "$$");//经营性合格证得分
			str.append(ifNull(record2.get("businesscertificateReason"))+ "$$");//经营性合格证原因
			str.append(record2.get("businesslicenseScore")+ "$$");//营业执照得分
			str.append(ifNull(record2.get("businesslicenseReason"))+ "$$");//营业执照原因
			str.append(record2.get("taxcertificateScore")+ "$$");//税务登记证得分
			str.append(ifNull(record2.get("taxcertificateReason"))+ "$$");//税务登记证原因
			str.append(record2.get("feeScore")+ "$$");//收费得分
			str.append(ifNull(record2.get("feeReason"))+ "$$");//收费原因
			str.append(record2.get("purchasegravesScore")+ "$$");//购置墓穴/安葬程序得分
			str.append(ifNull(record2.get("purchasegravesReason"))+ "$$");//购置墓穴/安葬程序原因
			str.append(record2.get("pledgeScore")+ "$$");//服务承诺得分
			str.append(ifNull(record2.get("pledgeReason"))+ "$$");//服务承诺原因
			str.append(record2.get("staffresponsibilitiesScore")+ "$$");//工作人员职责及照片、编号得分
			str.append(ifNull(record2.get("staffresponsibilitiesReason"))+ "$$");//工作人员职责原因
			str.append(record2.get("officeTimeScore")+ "$$");//办公时间、服务电话、监督电话得分
			str.append(ifNull(record2.get("officeTimeReason"))+ "$$");//办公时间、服务电话、监督电话原因
			str.append(record2.get("provincialdocumentsScore")+ "$$");//使用全省统一的《公墓安葬证》、《骨灰安放证》和《墓穴（格位）使用协议》得分
			str.append(ifNull(record2.get("provincialdocumentsReason"))+ "$$");//全省统一证原因
			str.append(record2.get("departmentchargesScore")+ "$$");//物价部门收费标准得分
			str.append(ifNull(record2.get("departmentchargesReason"))+ "$$");//物价部门收费标准原因
			str.append(record2.get("nooffenseScore")+ "$$");//无违法出租或买卖墓穴（格位）现象得分
			str.append(ifNull(record2.get("nooffenseReason"))+ "$$");//无违法出租原因
			str.append(record2.get("propergraveScore")+ "$$");//对超过20年的墓穴能够妥善处理得分
			str.append(ifNull(record2.get("propergraveReason"))+ "$$");//墓穴妥善处理原因
			str.append(record2.get("boxesandbagsScore")+ "$$");//使用全省统一的卷盒和卷袋得分
			str.append(ifNull(record2.get("boxesandbagsReason"))+ "$$");//统一卷盒原因
			str.append(record2.get("deathcertificateScore")+ "$$");//有死亡证明或火化证明的复印件得分
			str.append(ifNull(record2.get("deathcertificateReason"))+ "$$");//死亡证明复印件原因
			str.append(record2.get("ashescontractScore")+ "$$");//骨灰安放合同得分
			str.append(ifNull(record2.get("ashescontractReason"))+ "$$");//骨灰安放合同原因
			str.append(record2.get("contractorssignatureScore")+ "$$");//有丧事承办人签名的骨灰安放（葬）处理表、业务流程单等得分
			str.append(ifNull(record2.get("contractorssignatureReason"))+ "$$");//承办人签名原因
			str.append(record2.get("contractoridScore")+ "$$");//有丧事承办人的有效身份证件复印件得分
			str.append(ifNull(record2.get("contractoridReason"))+ "$$");//承办人身份证原因
			str.append(record2.get("addcontractScore")+ "$$");//有补充签订的合同或者协议得分
			str.append(ifNull(record2.get("addcontractReason"))+ "$$");//补充合同协议原因
			str.append(record2.get("othermaterialsScore")+ "$$");//有其他应当归档的材料得分
			str.append(ifNull(record2.get("othermaterialsReason"))+ "$$");//其他材料原因
			str.append(record2.get("tombstoneTwentyNum")+ "$$");//墓穴面积或墓碑高度超过规定标准20%以下的个数
			str.append(record2.get("tombstoneTwentyScore")+ "$$");//墓穴面积或墓碑高度超过规定标准20%以下的个数得分
			str.append(ifNull(record2.get("tombstoneTwentyReason"))+ "$$");//墓碑20%以下原因
			str.append(record2.get("tombstoneFiftyNum")+ "$$");//墓穴面积或墓碑高度超过规定标准20%至50%的个数
			str.append(record2.get("tombstoneFiftyScore")+ "$$");//墓穴面积或墓碑高度超过规定标准20%至50%的个数得分
			str.append(ifNull(record2.get("tombstoneFiftyReason"))+ "$$");//墓碑20%到50%原因
			str.append(record2.get("tombstoneoverfiftyNum")+ "$$");//墓穴面积或墓碑高度超过规定标准50%以上的个数
			str.append(record2.get("tombstoneoverfiftyScore")+ "$$");//墓穴面积或墓碑高度超过规定标准50%以上的个数得分
			str.append(ifNull(record2.get("tombstoneoverfiftyReason"))+ "$$");//墓碑50%以上原因
			str.append(record2.get("operatingareaNum")+ "$$");//营业室面积
			str.append(record2.get("operatingareaScore")+ "$$");//营业室面积得分
			str.append(ifNull(record2.get("operatingareaReason"))+ "$$");//营业室面积原因
			str.append(record2.get("archivesareaNum")+ "$$");//档案室面积
			str.append(record2.get("archivesareaScore")+ "$$");//档案室面积得分
			str.append(ifNull(record2.get("archivesareaReason"))+ "$$");//档案室面积原因
			str.append(record2.get("officeareaNum")+ "$$");//办公室面积
			str.append(record2.get("officeareaScore")+ "$$");//办公室面积得分
			str.append(ifNull(record2.get("officeareaReason"))+ "$$");//办公室面积原因
			str.append(record2.get("roadsafetyScore")+ "$$");//道路、供水、供电畅通，安全防护措施到位得分
			str.append(ifNull(record2.get("roadsafetyReason"))+ "$$");//道路供水原因
			str.append(record2.get("civilizationMemorialScore")+ "$$");//有文明祭奠举措，无封建迷信活动得分
			str.append(ifNull(record2.get("civilizationMemorialReason"))+ "$$");//文明祭奠原因
			str.append(record2.get("fireMemorialScore")+ "$$");//允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批得分
			str.append(ifNull(record2.get("fireMemorialReason"))+ "$$");//明火祭奠原因
			str.append(record2.get("ecologyNum")+ "$$");//生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例
			str.append(record2.get("ecologyScore")+ "$$");//生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例得分
			str.append(ifNull(record2.get("ecologyReason"))+ "$$");//生态原因
			str.append(record2.get("greenCoverageNum")+ "$$");//绿化覆盖率
			str.append(record2.get("greenCoverageScore")+ "$$");//绿化覆盖率得分
			str.append(ifNull(record2.get("greenCoverageReason"))+ "$$");//绿化率原因
			str.append(record2.get("greenareaRatioNum")+ "$$");//绿地面积和占总面积的比例
			str.append(record2.get("greenareaRatioScore")+ "$$");//绿地面积和占总面积的比例得分
			str.append(ifNull(record2.get("greenareaRatioReason"))+ "$$");//绿地面积比率原因
			str.append(record2.get("burialTombScore")+ "$$");//按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）得分
			str.append(ifNull(record2.get("burialTombReason"))+ "$$");//标准安葬墓穴原因
			str.append(record2.get("burialConformScore")+ "$$");//墓区建设地点和规模与申报材料相符得分
			str.append(ifNull(record2.get("burialConformReason"))+ "$$");//墓区相符原因
			str.append(record2.get("acceptanceComplianceScore")+ "$$");//新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定得分
			str.append(ifNull(record2.get("acceptanceComplianceReason"))+ "$$");//手续符合规定原因
			str.append(record2.get("changeComplianceScore")+ "$$");//公墓更名、变更法人代表，改变性质或改变合作（合资）单位符合《山东省公墓管理办法》规定得分
			str.append(ifNull(record2.get("changeComplianceReason"))+ "$$");//改变符合规定/公墓更名符合规定原因
			str.append(record2.get("paymentCertificateScore")+ "$$");//公墓根据销售墓穴的数量和使用年限，有不低于6%的税后收入预留，有交款凭证得分
			str.append(ifNull(record2.get("paymentCertificateReason"))+ "$$");//有交款凭证原因
			str.append(record2.get("agenciesScore")+ "$$");//墓区管理机构的组建与申报报告相符得分
			str.append(ifNull(record2.get("agenciesReason"))+ "$$");//管理机构组建相符原因
			str.append(record2.get("businessTrainingScore")+ "$$");//工作人员参加省或设区的市人民政府民政部门组织的业务培训得分
			str.append(ifNull(record2.get("businessTrainingReason"))+ "$$");//业务培训原因
			str.append(record2.get("systemSoundScore")+ "$$");//公墓管理的各项规章制度健全得分
			str.append(ifNull(record2.get("systemSoundReason"))+ "$$");//规章制度健全原因
			str.append(record2.get("contingencyPlansScore")+ "$$");//有高峰应急预案得分
			str.append(ifNull(record2.get("contingencyPlansReason"))+ "$$");//应急预案原因
			str.append(record2.get("informationScore")+ "$$");//实行信息化管理，使用省厅研制的软件信息系统得分
			str.append(ifNull(record2.get("informationReason"))+ "$$");//信息化原因
			
		DataSet ds3 = fisCemeCheckAuditDao.query(pset);
			Record record3 = ds3.getRecord(0);
			str.append(record3.get("totalScore")+ "$$");//年检总得分
			str.append(ifNull(record3.get("annuareport"))+ "$$");//年检报告
			
		return str.toString();
	}
}