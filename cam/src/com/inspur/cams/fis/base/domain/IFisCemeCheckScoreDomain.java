package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeCheckScore;

/**
 * 公墓年检打分domain
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeCheckScoreDomain {

	/**
	 * 查询 公墓年检打分
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 公墓年检打分
	 * @param pset
	 * @return
	 */
	public FisCemeCheckScore get(String scoreId);

	/**
	 * 增加 公墓年检打分
	 * @param fisCemeCheckScore
	 */
	@Trans
	public void insert(FisCemeCheckScore fisCemeCheckScore);
	
	/**
	 * 修改 公墓年检打分
	 * @param fisCemeCheckScore
	 */
	@Trans
	public void update(FisCemeCheckScore fisCemeCheckScore);
	
	/**
	 * 删除 公墓年检打分
	 * @param scoreId
	 */
	@Trans
	public void delete(String scoreId);
	//查询公墓年检打分
	public DataSet queryScore(ParameterSet pset);
	@Trans
	public void insertAll(FisCemeCheckScore fisCemeCheckScore);
}