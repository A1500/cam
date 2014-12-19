package com.inspur.comm.cqm.base.cmd;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmCol;
import com.inspur.comm.cqm.base.data.CqmReport;
import com.inspur.comm.cqm.base.data.CqmUseCol;
import com.inspur.comm.cqm.base.data.CqmUseCondition;
import com.inspur.comm.cqm.base.data.CqmUseView;
import com.inspur.comm.cqm.base.data.CqmView;
import com.inspur.comm.cqm.base.domain.ICqmColDomain;
import com.inspur.comm.cqm.base.domain.ICqmReportDomain;

/**
 * 自定义统计报表cmd
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmReportCmd extends BaseAjaxCommand {

	private ICqmReportDomain cqmReportDomain = ScaComponentFactory
			.getService(ICqmReportDomain.class, "cqmReportDomain/cqmReportDomain");
	private ICqmColDomain cqmColDomain = ScaComponentFactory
	.getService(ICqmColDomain.class, "cqmColDomain/cqmColDomain");
	
	// 增加
	public void insert() {
		Record cqmReportRecord = (Record) getParameter("cqmReportRecord");
		CqmReport cqmReport = (CqmReport) cqmReportRecord.toBean(CqmReport.class);
		
		List viewList = (List) getParameter("viewList");
		Map relColMap = (Map) getParameter("relColMap");
		Map viewPrivilegeMap = (Map) getParameter("viewPrivilegeMap");
		Map viewUnderingMap = (Map) getParameter("viewUnderingMap");
		List<CqmUseView> cqmUseViewList = new ArrayList<CqmUseView>();
		for (int i = 0; i < viewList.size(); i++) {
			Record cqmViewRecord = (Record) viewList.get(i);
			CqmView cqmView = (CqmView) cqmViewRecord.toBean(CqmView.class);
			
			String relColId = (String) relColMap.get(cqmView.getViewId());
			CqmCol relCqmCol = cqmColDomain.get(relColId);
			CqmUseView cqmUseView = new CqmUseView();
			cqmUseView.setViewId(cqmView.getViewId());
			cqmUseView.setViewName(cqmView.getViewName());
			cqmUseView.setViewLogic(cqmView.getViewLogic());
			cqmUseView.setViewCode(relCqmCol.getColCode());
			cqmUseView.setIfUndering((String)viewUnderingMap.get(cqmView.getViewId()));
			cqmUseView.setPrivilegeCode((String)viewPrivilegeMap.get(cqmView.getViewId()));
			cqmUseViewList.add(cqmUseView);
		}
		cqmReport.setCqmUseViewList(cqmUseViewList);
		cqmReportDomain.insert(cqmReport);
		setReturn("reportId", cqmReport.getReportId());
	}
	
	// 修改
	public void update() {
		Record cqmReportRecord = (Record) getParameter("cqmReportRecord");
		CqmReport cqmReport = (CqmReport) cqmReportRecord.toBean(CqmReport.class);
		
		List viewList = (List) getParameter("viewList");
		Map relColMap = (Map) getParameter("relColMap");
		Map viewPrivilegeMap = (Map) getParameter("viewPrivilegeMap");
		Map viewUnderingMap = (Map) getParameter("viewUnderingMap");
		List<CqmUseView> cqmUseViewList = new ArrayList<CqmUseView>();
		for (int i = 0; i < viewList.size(); i++) {
			Record cqmViewRecord = (Record) viewList.get(i);
			CqmView cqmView = (CqmView) cqmViewRecord.toBean(CqmView.class);
			
			String relColId = (String) relColMap.get(cqmView.getViewId());
			CqmCol relCqmCol = cqmColDomain.get(relColId);
			
			CqmUseView cqmUseView = new CqmUseView();
			cqmUseView.setViewId(cqmView.getViewId());
			cqmUseView.setViewName(cqmView.getViewName());
			cqmUseView.setViewLogic(cqmView.getViewLogic());
			cqmUseView.setViewCode(relCqmCol.getColCode());
			cqmUseView.setIfUndering((String)viewUnderingMap.get(cqmView.getViewId()));
			cqmUseView.setPrivilegeCode((String)viewPrivilegeMap.get(cqmView.getViewId()));
			cqmUseViewList.add(cqmUseView);
		}
		cqmReport.setCqmUseViewList(cqmUseViewList);
		
		
		cqmReportDomain.update(cqmReport);
	}
	
	/**
	 * 更新查询列
	 */
	public void updateUserCols(){
		Record[] userCols = (Record[]) getParameter("userColRecords");
		String reportId = (String) getParameter("reportId");
		List<CqmUseCol> cqmUseColList = new ArrayList<CqmUseCol>();
		if(userCols!=null){
			for (int i = 0; i < userCols.length; i++) {
				Record cqmColRecord = (Record) userCols[i];
				CqmCol cqmCol = (CqmCol) cqmColRecord.toBean(CqmCol.class);
				CqmUseCol cqmUseCol = new CqmUseCol();
				cqmUseCol.setViewId(cqmCol.getViewId());
				cqmUseCol.setColId(cqmCol.getColId());
				cqmUseCol.setColCode(cqmCol.getColCode());
				String[] colNames = cqmCol.getColName().split(":");
				if(colNames.length>1){
					cqmUseCol.setColName(colNames[colNames.length-1]);
				}else{
					cqmUseCol.setColName(cqmCol.getColName());
				}
				cqmUseCol.setColType(cqmCol.getColType());
				cqmUseCol.setIndexId(cqmCol.getIndexId());
				cqmUseCol.setState(cqmCol.getState());
				cqmUseColList.add(cqmUseCol);
			}
		}
		CqmReport cqmReport = cqmReportDomain.get(reportId);
		cqmReport.setCqmUseColList(cqmUseColList);
		cqmReportDomain.updateUserCols(cqmReport);
	}
	// 删除
	public void delete() {
		String reportId = (String) getParameter("reportId");
		cqmReportDomain.delete(reportId);
	}
	
	public void updateUseConditions(){
		String reportId = (String) getParameter("reportId");
		String viewId = (String) getParameter("viewId");
		Record[] records = (Record[]) getParameter("records");
		List<CqmUseCondition> conditions = new ArrayList<CqmUseCondition>();
		for(int i = 0 ; i < records.length;i++ ){
			CqmUseCondition condition = (CqmUseCondition) records[i].toBean(CqmUseCondition.class);
			conditions.add(condition);
		}
		cqmReportDomain.updateUseConditions(reportId,viewId,conditions);
	}
	
}