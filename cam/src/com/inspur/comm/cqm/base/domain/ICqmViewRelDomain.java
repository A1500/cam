package com.inspur.comm.cqm.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.comm.cqm.base.data.CqmViewRel;

/**
 * 自定义统计报表模型视图关系domain
 * @author shgtch
 * @date 2012-03-16
 */
public interface ICqmViewRelDomain {

	/**
	 * 查询 自定义统计报表模型视图关系
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 保存模型视图关系
	 * @param list
	 */
	public void save(List<CqmViewRel> list);
	
	/**
	 * 增加 自定义统计报表模型视图关系
	 * @param cqmViewRel
	 */
	@Trans
	public void insert(CqmViewRel cqmViewRel);
	
	/**
	 * 修改 自定义统计报表模型视图关系
	 * @param cqmViewRel
	 */
	@Trans
	public void update(CqmViewRel cqmViewRel);
	
	/**
	 * 删除 自定义统计报表模型视图关系
	 * @param relId
	 */
	@Trans
	public void delete(String relId);

}