package com.inspur.comm.cqm.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.util.IdHelp;
import com.inspur.comm.cqm.base.dao.ICqmUseSearchDao;
import com.inspur.comm.cqm.base.data.CqmUseSearch;
import com.inspur.comm.cqm.base.domain.ICqmUseSearchDomain;

/**
 * 自定义报表查询逻辑domain
 * @author 
 * @date 2012-05-02
 */
public class CqmUseSearchDomain implements ICqmUseSearchDomain {

	@Reference
	private ICqmUseSearchDao cqmUseSearchDao;

	/**
	 * 查询 自定义报表查询逻辑
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cqmUseSearchDao.query(pset);
	}

	/**
	 * 获取 自定义报表查询逻辑
	 * @param pset
	 * @return
	 */
	public CqmUseSearch get(String searchId) {
		return cqmUseSearchDao.get(searchId);
	}

	/**
	 * 增加 自定义报表查询逻辑
	 * @param cqmUseSearch
	 */
	public void insert(CqmUseSearch cqmUseSearch) {
		cqmUseSearchDao.insert(cqmUseSearch);
	}
	
	/**
	 * 修改 自定义报表查询逻辑
	 * @param cqmUseSearch
	 */
	public void update(CqmUseSearch cqmUseSearch) {
		cqmUseSearchDao.update(cqmUseSearch);
	}
	
	/**
	 * 删除 自定义报表查询逻辑
	 * @param searchId
	 */
	public void delete(String searchId) {
		cqmUseSearchDao.delete(searchId);
	}

	public void deleteByReportId(String reportId) {
		cqmUseSearchDao.deleteByReportId(reportId);
	}

	public void updateUserSearchCols(String reportId,
			List<CqmUseSearch> useSearch) {
		cqmUseSearchDao.deleteByReportId(reportId);
		for (CqmUseSearch cqmUseSearch : useSearch) {
			cqmUseSearch.setReportId(reportId);
			cqmUseSearch.setSearchId(IdHelp.getUUID32());
			String[] colNames = cqmUseSearch.getColName().split(":");
			if(colNames.length>1){
				cqmUseSearch.setColName(colNames[colNames.length-1]);
			}
			if("D".equals(cqmUseSearch.getColType())){
				cqmUseSearch.setSearchOper("J");
			}else if("S".equals(cqmUseSearch.getColType())){
				cqmUseSearch.setSearchOper("F");
			}
			cqmUseSearchDao.insert(cqmUseSearch);
		}
	}

	public DataSet queryUserSearch(ParameterSet pset) {
		
		return cqmUseSearchDao.queryUserSearch(pset);
	}

}