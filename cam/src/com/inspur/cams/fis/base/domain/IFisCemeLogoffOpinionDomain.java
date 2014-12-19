package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeLogoffOpinion;

/**
 * 同级其它部门意见domain
 * @author 
 * @date 2013-08-15
 */
public interface IFisCemeLogoffOpinionDomain {

	/**
	 * 查询 同级其它部门意见
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 同级其它部门意见
	 * @param pset
	 * @return
	 */
	public FisCemeLogoffOpinion get(String opinionId);

	/**
	 * 增加 同级其它部门意见
	 * @param fisCemeLogoffOpinion
	 */
	@Trans
	public void insert(FisCemeLogoffOpinion fisCemeLogoffOpinion);
	
	/**
	 * 修改 同级其它部门意见
	 * @param fisCemeLogoffOpinion
	 */
	@Trans
	public void update(FisCemeLogoffOpinion fisCemeLogoffOpinion);
	
	/**
	 * 删除 同级其它部门意见
	 * @param opinionId
	 */
	@Trans
	public void delete(String opinionId);

}