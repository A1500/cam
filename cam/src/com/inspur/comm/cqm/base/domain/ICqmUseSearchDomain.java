package com.inspur.comm.cqm.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.comm.cqm.base.data.CqmUseSearch;

/**
 * 自定义报表查询逻辑domain
 * @author 
 * @date 2012-05-02
 */
public interface ICqmUseSearchDomain {

	/**
	 * 查询 自定义报表查询逻辑
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 自定义报表查询逻辑
	 * @param pset
	 * @return
	 */
	public CqmUseSearch get(String searchId);

	/**
	 * 增加 自定义报表查询逻辑
	 * @param cqmUseSearch
	 */
	@Trans
	public void insert(CqmUseSearch cqmUseSearch);
	
	/**
	 * 修改 自定义报表查询逻辑
	 * @param cqmUseSearch
	 */
	@Trans
	public void update(CqmUseSearch cqmUseSearch);
	
	/**
	 * 删除 自定义报表查询逻辑
	 * @param searchId
	 */
	@Trans
	public void delete(String searchId);

	/**
	 *
	 * @param reportId
	 */
	public void deleteByReportId(String reportId);

	/**
	 *  更新某报表的查询条件
	 * @param reportId
	 * @param useSearch
	 */
	@Trans
	public void updateUserSearchCols(String reportId,
			List<CqmUseSearch> useSearch);

	/**
	 * 自己拼装的查询
	 * @param pset
	 * @return
	 */
	public DataSet queryUserSearch(ParameterSet pset);

}