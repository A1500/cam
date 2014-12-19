package com.inspur.cams.bpt.capital.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.capital.data.BptCapitalDetail;

public interface IBptCapialDetailDomain {
	/**
	  * 获得上期生成日期
	  * @param organId
	  */
	public String[] getPreBuildDate(String organId,String registerType);
	
	/**
	 * 通过调用存储过程添加伤残抚恤金发放名册明细
	 * @param pset
	 */
	public void insertDisaPesionDetail(ParameterSet pset);
	
	/**
	 * 通过调用存储过程添加三属定期抚恤金发放名册明细
	 * @param pset
	 */
	public void insertDepdtPesionDetail(ParameterSet pset);
	
	/**
	 * 通过调用存储过程添加复员军人定期定量生活补助金发放明细
	 */
	public void insertDemobilizedPesionDetail(ParameterSet pset);
	
	/**
	 * 添加{带病回乡退伍军人}生活补助金发放明细--调用存储过程
	 */
	public void insertDemobilizedPesionIllDetail(ParameterSet pset);
	
	/**
	 * 通过调用存储过程添加生活补助费发放明细
	 */
	public void insertLivingAllowPesionDetail(ParameterSet pset);
	
	public void saveBptCapialDetail(List<BptCapitalDetail> list);
	public DataSet queryDisabilityDataSet(ParameterSet pset);
//	public DataSet queryGeneraDataSet(ParameterSet pset);
//	public DataSet queryLifeDataSet(ParameterSet pset);
	public void batchBptCapialDetail(List<BptCapitalDetail> list);
	public void updateData(ParameterSet pset);
	public void deleteData(String[] delIds);
	//public DataSet queryGrantFund(ParameterSet pset);
	
	/**
	 * 获取新增的伤残抚恤金发放对象
	 */
	public DataSet getNewDisabiGrantDs(ParameterSet pset);
	/**
	 * 获取新增的三属抚恤金发放对象
	 */
	public DataSet getNewDepandGrantDs(ParameterSet pset);
	/**
	 * 获取新增的复员军人抚恤金发放对象
	 */
	public DataSet getNewDemobilizedGrantDs(ParameterSet pset);
	
	/**
	 * 获取新增的带病回乡退伍军人发放对象
	 */
	public DataSet getNewDemobilizedIllGrantDs(ParameterSet pset);
	
	/**
	 * 获取新增的生活补助费发放对象
	 */
	public DataSet getNewLiveAllowGrantDs(ParameterSet pset);
	/**
	 * 导出数据
	 */
	public DataSet queryExportData(ParameterSet pset);
	
	/**
	 * 添加{60岁}生活补助金发放明细
	 */
	public void insertSoldierPesionIllDetail(ParameterSet pset);
	
	/**
	 * 获取新增的60岁抚恤金发放对象
	 */
	public DataSet getNewSoldierGrantDs(ParameterSet pset);
	
	/**
	 * 添加{老烈子女}生活补助金发放明细
	 */
	public void insertMartyrPesionIllDetail(ParameterSet pset);
	
	/**
	 * 获取新增的老烈子女抚恤金发放对象
	 */
	public DataSet getNewMartyrGrantDs(ParameterSet pset);
}
