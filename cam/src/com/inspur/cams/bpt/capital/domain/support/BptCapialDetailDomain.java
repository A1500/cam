package com.inspur.cams.bpt.capital.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.capital.dao.IBptCapitalDetailDao;
import com.inspur.cams.bpt.capital.data.BptCapitalDetail;
import com.inspur.cams.bpt.capital.domain.IBptCapialDetailDomain;

public class BptCapialDetailDomain implements IBptCapialDetailDomain {
    @Reference
    private IBptCapitalDetailDao bptCapitalDetailDao;
    
    /**
	  * 获得上期生成日期
	  * @param organId
	  */
	public String[] getPreBuildDate(String organId,String registerType){
		return bptCapitalDetailDao.getPreBuildDate(organId,registerType);
	}
	
	/**
	 * 通过调用存储过程添加伤残抚恤金发放名册明细
	 * @param pset
	 */
	public void insertDisaPesionDetail(ParameterSet pset){
		bptCapitalDetailDao.insertDisaPesionDetail(pset);
	}
	
	/**
	 * 通过调用存储过程添加三属定期抚恤金发放名册明细
	 * @param pset
	 */
	public void insertDepdtPesionDetail(ParameterSet pset){
		bptCapitalDetailDao.insertDepdtPesionDetail(pset);
	}
	
	/**
	 * 添加复员军人定期定量生活补助金发放明细
	 */
	public void insertDemobilizedPesionDetail(ParameterSet pset){
		bptCapitalDetailDao.insertDemobilizedPesionDetail(pset);
	}
	
	/**
	 * 添加{带病回乡退伍军人}生活补助金发放明细--调用存储过程
	 */
	public void insertDemobilizedPesionIllDetail(ParameterSet pset){
		bptCapitalDetailDao.insertDemobilizedPesionIllDetail(pset);
	}
	
	/**
	 * 通过调用存储过程添加生活补助费发放明细
	 */
	public void insertLivingAllowPesionDetail(ParameterSet pset){
		bptCapitalDetailDao.insertLivingAllowPesionDetail(pset);
	}
    
	public DataSet queryDisabilityDataSet(ParameterSet pset) {
		return bptCapitalDetailDao.queryDisabilityDataSet(pset);
	}

//	public DataSet queryGeneraDataSet(ParameterSet pset) {
//		return bptCapitalDetailDao.queryGeneraDataSet(pset);
//	}

//	public DataSet queryLifeDataSet(ParameterSet pset) {
//		return bptCapitalDetailDao.queryLifeDataSet(pset);
//	}

	public void updateData(ParameterSet pset) {
		bptCapitalDetailDao.updateData(pset);
	}

	public void deleteData(String[] delIds) {
		bptCapitalDetailDao.deleteData(delIds);
	}
	
	public void saveBptCapialDetail(List<BptCapitalDetail> list) {
		bptCapitalDetailDao.save(list);
	}

	public void batchBptCapialDetail(List<BptCapitalDetail> list) {
		bptCapitalDetailDao.batchInsert(list);
	}

//	public DataSet queryGrantFund(ParameterSet pset) {
//		return bptCapitalDetailDao.queryGrantFund(pset);
//	}
	
	/**
	 * 获取新增的伤残抚恤金发放对象
	 */
	public DataSet getNewDisabiGrantDs(ParameterSet pset){
		return bptCapitalDetailDao.getNewDisabiGrantDs(pset);
	}
	
	/**
	 * 获取新增的三属抚恤金发放对象
	 */
	public DataSet getNewDepandGrantDs(ParameterSet pset){
		return bptCapitalDetailDao.getNewDepandGrantDs(pset);
	}
	
	/**
	 * 获取新增的复员军人抚恤金发放对象
	 */
	public DataSet getNewDemobilizedGrantDs(ParameterSet pset){
		return bptCapitalDetailDao.getNewDemobilizedGrantDs(pset);
	}
	
	/**
	 * 获取新增的带病回乡退伍军人发放对象
	 */
	public DataSet getNewDemobilizedIllGrantDs(ParameterSet pset){
		return bptCapitalDetailDao.getNewDemobilizedIllGrantDs(pset);
	}
	
	/**
	 * 获取新增的生活补助费发放对象
	 */
	public DataSet getNewLiveAllowGrantDs(ParameterSet pset){
		return bptCapitalDetailDao.getNewLiveAllowGrantDs(pset);
	}
	/**
	 * 导出数据
	 */
	public DataSet queryExportData(ParameterSet pset){
		return bptCapitalDetailDao.queryExportData(pset);
	}
	/**
	 * 添加{60岁}生活补助金发放明细
	 */
	public void insertSoldierPesionIllDetail(ParameterSet pset){
		bptCapitalDetailDao.insertSoldierPesionIllDetail(pset);
	}
	
	/**
	 * 获取新增的60岁抚恤金发放对象
	 */
	public DataSet getNewSoldierGrantDs(ParameterSet pset){
		return bptCapitalDetailDao.getNewSoldierGrantDs(pset);
	}
	/**
	 * 添加{60岁}生活补助金发放明细
	 */
	public void insertMartyrPesionIllDetail(ParameterSet pset){
		bptCapitalDetailDao.insertMartyrPesionIllDetail(pset);
	}
	/**
	 * 获取新增的老烈子女抚恤金发放对象
	 */
	public DataSet getNewMartyrGrantDs(ParameterSet pset){
		return bptCapitalDetailDao.getNewMartyrGrantDs(pset);
	}
}
