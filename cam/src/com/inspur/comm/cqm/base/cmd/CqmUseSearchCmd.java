package com.inspur.comm.cqm.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmUseSearch;
import com.inspur.comm.cqm.base.domain.ICqmUseSearchDomain;

/**
 * 自定义报表查询逻辑cmd
 * @author 
 * @date 2012-05-02
 */
public class CqmUseSearchCmd extends BaseAjaxCommand {

	private ICqmUseSearchDomain cqmUseSearchDomain = ScaComponentFactory
			.getService(ICqmUseSearchDomain.class, "cqmUseSearchDomain/cqmUseSearchDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CqmUseSearch cqmUseSearch = (CqmUseSearch) record.toBean(CqmUseSearch.class);
		cqmUseSearchDomain.insert(cqmUseSearch);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CqmUseSearch cqmUseSearch = (CqmUseSearch) record.toBean(CqmUseSearch.class);
		cqmUseSearchDomain.update(cqmUseSearch);
	}
	
	// 删除
	public void delete() {
		String searchId = (String) getParameter("searchId");
		cqmUseSearchDomain.delete(searchId);
	}
	public void updateUserSearchCols(){
		Record[] records = (Record[]) getParameter("records");
		String reportId = (String) getParameter("reportId");
		List<CqmUseSearch> useSearch = new ArrayList<CqmUseSearch>();
		if(records!=null){
			for(int i = 0;i<records.length;i++){
				CqmUseSearch  search = (CqmUseSearch) records[i].toBean(CqmUseSearch.class); 
				useSearch.add(search);
			}
			cqmUseSearchDomain.updateUserSearchCols(reportId,useSearch);
		}else{
			cqmUseSearchDomain.deleteByReportId(reportId);
		}
	}
}