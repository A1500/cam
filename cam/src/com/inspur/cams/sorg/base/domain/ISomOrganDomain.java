package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomOrgan;

/**
 * 社会组织domain接口
 * @author Muqi
 * @date 2011-5-11
 */
public interface ISomOrganDomain {
	
	/**
	 * 查询社会组织信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 增加社会组织信息
	 * @param dataBean
	 */
	@Trans
	public void insert(SomOrgan dataBean);
	/**
	 * 更新社会组织信息
	 * @param dataBean
	 */
	@Trans
	public void update(SomOrgan dataBean);
	/**
	 * 批量增加社会组织信息
	 * @param dataBean
	 */
	@Trans
	public void batchInsert(List<SomOrgan> lists);
	/**
	 * 批量更新社会组织信息
	 * @param dataBean
	 */
	@Trans
	public void batchUpdate(List<SomOrgan> lists);
	/**
	 * 更新社会组织中的党建字段
	 */
	@Trans
	public void updateRegPartyById(String sorgId,String status);
	/**
	 * 更新换届选举日期
	 */
	@Trans
	public void updateElectionDate(String sorgId,String electionDate,Integer electionPriod);
	/**
	 * 社会组织信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryOrgan(ParameterSet pset);

	/**
	 * 主体基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMain(ParameterSet pset);

	/**
	 * 分支基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryBranch(ParameterSet pset);
	
	/**
	 * 分支基本信息的综合查询
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet totalQueryBranch(ParameterSet pset);
	
	/**
	 * 查询社会组织名称是否重复
	 */
	public String cnNameUK(ParameterSet pset);
	
	/**
	 * 查询登记证号是否重复
	 */
	public String sorgCodeUK(ParameterSet pset);
	
	/**
	 * 查询主体对应的未注销分支机构状态的数量
	 */
	public String branchStatusNum(String mainMorgId);
	
	/**
	 * 查询社会组织名称
	 * 
	 * @param pset
	 * @return String
	 */
	public String queryOrganName(ParameterSet pset);
	/**
	 * 查询社会组织名称和登记证号
	 * 
	 * @param pset
	 * @return String
	 */
	public Record queryOrganNameAndSorgCode(ParameterSet pset);
	
	/**
	 * 查询社会组织名称相似
	 */
	public String cnNameSame(ParameterSet pset);
	
	/**
	 * 增加社会组织信息并保存历史记录
	 * @param dataBean
	 */
	public void insertAndBuildHis(SomOrgan dataBean,String taskCode) ;
	
	/**
	 * 修改社会组织信息并修改历史记录
	 * @param dataBean
	 * @param applyType
	 */
	public void updateAndBuildHis(SomOrgan dataBean,String taskCode);
	
	/**
	 * 根据taskCode查询社团历史信息
	 * @param pset
	 * @return
	 */
	public DataSet queryHis(ParameterSet pset);
	
	/**
	 * 取消社会组织限期停止活动状态
	 */
	public void cancelLimitPeriod(ParameterSet pset);
	/**
	 * 名称核准作废，更新sorg_status为7
	 */
	public void updateSorgStatus(ParameterSet pset);
}
