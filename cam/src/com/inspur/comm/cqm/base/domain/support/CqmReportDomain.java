package com.inspur.comm.cqm.base.domain.support;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.cqm.base.dao.ICqmReportDao;
import com.inspur.comm.cqm.base.data.CqmIndex;
import com.inspur.comm.cqm.base.data.CqmReport;
import com.inspur.comm.cqm.base.data.CqmUseCol;
import com.inspur.comm.cqm.base.data.CqmUseCondition;
import com.inspur.comm.cqm.base.data.CqmUseView;
import com.inspur.comm.cqm.base.domain.ICqmIndexDomain;
import com.inspur.comm.cqm.base.domain.ICqmReportDomain;
import com.inspur.comm.cqm.base.domain.ICqmUseColDomain;
import com.inspur.comm.cqm.base.domain.ICqmUseConditionDomain;
import com.inspur.comm.cqm.base.domain.ICqmUseViewDomain;
import com.inspur.comm.util.BspUtil;
import com.inspur.comm.util.DateUtil;
import com.inspur.comm.util.IdHelp;

/**
 * 自定义统计报表domain
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmReportDomain implements ICqmReportDomain {

	@Reference
	private ICqmReportDao cqmReportDao;
	
	@Reference
	private ICqmIndexDomain cqmIndexDomain;
	
	@Reference
	private ICqmUseViewDomain cqmUseViewDomain;
	
	@Reference
	private ICqmUseColDomain cqmUseColDomain;
	
	@Reference
	private ICqmUseConditionDomain cqmUseConditionDomain;
	
	/**
	 * 查询 自定义统计报表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cqmReportDao.query(pset);
	}

	/**
	 * 查询报表行
	 * @param rowLogic
	 * @return
	 */
	public DataSet getReportRow(String organCode,CqmIndex cqmIndex) {
		return cqmReportDao.getReportRow(organCode,cqmIndex);
	}

	/**
	 * 查询数据
	 * @param logic
	 * @return
	 */
	public DataSet getReportData(String organCode,CqmUseCol cqmUseCol, CqmIndex cqmIndex, List cqmUseSearchList) {
		CqmUseView useView = cqmUseViewDomain.get(cqmUseCol.getReportId(),cqmUseCol.getViewId());
		if("Q".equals(cqmUseCol.getColType())){
			List sections = cqmIndexDomain.getSectionIndexData(cqmUseCol.getIndexId());
			return cqmReportDao.getReportData(organCode,cqmUseCol,useView, sections,cqmIndex, cqmUseSearchList);
		}else{
			return cqmReportDao.getReportData(organCode,cqmUseCol,useView, cqmIndex, cqmUseSearchList);
		}
	}

	/**
	 * 查询报表数据
	 * @param logic
	 * @return
	 */
	public DataSet getReportSum(String organCode,CqmUseCol cqmUseCol,CqmIndex cqmIndex, List cqmUseSearchList) {
		CqmUseView useView = cqmUseViewDomain.get(cqmUseCol.getReportId(),cqmUseCol.getViewId());
		if("Q".equals(cqmUseCol.getColType())){
			List sections = cqmIndexDomain.getSectionIndexData(cqmUseCol.getIndexId());
			return cqmReportDao.getReportSum(organCode,cqmUseCol,useView,sections,cqmIndex, cqmUseSearchList);
		}else{
			return cqmReportDao.getReportSum(organCode,cqmUseCol,useView,cqmIndex, cqmUseSearchList);
		}
		
	}

	/**
	 * 获取 自定义统计报表
	 * @param pset
	 * @return
	 */
	public CqmReport get(String reportId) {
		return cqmReportDao.get(reportId);
	}

	/**
	 * 增加 自定义统计报表
	 * @param cqmReport
	 */
	public void insert(CqmReport cqmReport) {
		cqmReport.setReportId(IdHelp.getUUID32());
		cqmReport.setCreateOrgan(BspUtil.getCorpOrgan().getOrganName());
		cqmReport.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		cqmReport.setCreateTime(DateUtil.getTime19());
		List<CqmUseView> cqmUseViewList = cqmReport.getCqmUseViewList();
		for (int i = 0; i < cqmUseViewList.size(); i++) {
			CqmUseView cqmUseView = (CqmUseView) cqmUseViewList.get(i);
			cqmUseView.setUseViewId(IdHelp.getUUID32());
			cqmUseView.setReportId(cqmReport.getReportId());
			cqmUseViewDomain.insert(cqmUseView);
		}
		cqmReportDao.insert(cqmReport);
	}
	
	/**
	 * 修改 自定义统计报表
	 * @param cqmReport
	 */
	public void update(CqmReport cqmReport) {
		List<CqmUseView> cqmUseViewList = cqmReport.getCqmUseViewList();
		cqmUseViewDomain.deleteByReportId(cqmReport.getReportId());
		for (int i = 0; i < cqmUseViewList.size(); i++) {
			CqmUseView cqmUseView = (CqmUseView) cqmUseViewList.get(i);
			cqmUseView.setUseViewId(IdHelp.getUUID32());
			cqmUseView.setReportId(cqmReport.getReportId());
			cqmUseViewDomain.insert(cqmUseView);
		}
		cqmReportDao.update(cqmReport);
	}
	
	/**
	 * 删除 自定义统计报表
	 * @param reportId
	 */
	public void delete(String reportId) {
		cqmReportDao.delete(reportId);
		cqmUseColDomain.deleteByReportId(reportId);
		cqmUseViewDomain.deleteByReportId(reportId);
		cqmUseConditionDomain.deleteByReportId(reportId);
	}

	public void updateUserCols(CqmReport cqmReport) {
		List<CqmUseCol> cqmUseColList = cqmReport.getCqmUseColList();
		cqmUseColDomain.deleteByReportId(cqmReport.getReportId());
		List<CqmUseView> useViewList = cqmUseViewDomain.getUseViews(cqmReport.getReportId());
		
		StringBuffer titleJson = new StringBuffer();
		titleJson.append("{\"r\":[");
		for (int i = 0; i < useViewList.size(); i++) {
			CqmUseView cqmUseView = useViewList.get(i);
			if (i != 0) {
				titleJson.append(",");
			}
			titleJson.append("{\"vi\":\"");
			titleJson.append(cqmUseView.getViewId());
			titleJson.append("\",\"vn\":\"");
			titleJson.append(cqmUseView.getViewName());
			titleJson.append("\",\"v\":[");
			
			int colNum = 0;
			for (int j = 0; j < cqmUseColList.size(); j++) {
				CqmUseCol cqmUseCol = cqmUseColList.get(j);
				if (cqmUseView.getViewId().equals(cqmUseCol.getViewId())) {
					cqmUseCol.setUseColId(IdHelp.getUUID32());
					cqmUseCol.setReportId(cqmReport.getReportId());
					cqmUseCol.setViewLogic(cqmUseView.getViewLogic());
					cqmUseCol.setViewCode(cqmUseView.getViewCode());
					
					if (colNum != 0) {
						titleJson.append(",");
					}
					colNum++;
					titleJson.append("{\"ci\":\"");
					titleJson.append(cqmUseCol.getColId());
					titleJson.append("\",\"cn\":\"");
					titleJson.append(cqmUseCol.getColName());
					titleJson.append("\",\"ct\":\"");
					titleJson.append(cqmUseCol.getColType());
					titleJson.append("\"");
					
					if ("D".equals(cqmUseCol.getColType())) {
						titleJson.append(",\"cc\":[");
						List list = cqmIndexDomain.getIndexData(cqmUseCol.getIndexId());
						CqmIndex index = cqmIndexDomain.get(cqmUseCol.getIndexId());
						if("1".equals(index.getIfSum())){
							titleJson.append("{\"c\":\""+cqmUseCol.getColId()+"CODE");
							titleJson.append("\",\"n\":\"合计");
							titleJson.append("\"}");
						}
						for (int k = 0; k < list.size(); k++) {
							Map map = (Map) list.get(k);
							if("1".equals(index.getIfSum())){
								titleJson.append(",");
								titleJson.append("{\"c\":\"");
								titleJson.append(cqmUseCol.getColId());
								titleJson.append(map.get("CODE"));
								titleJson.append("\",\"n\":\"");
								titleJson.append(map.get("NAME"));
								titleJson.append("\"}");
							}else{
								if (k != 0) {
									titleJson.append(",");
								}
								titleJson.append("{\"c\":\"");
								titleJson.append(cqmUseCol.getColId());
								titleJson.append(map.get("CODE"));
								titleJson.append("\",\"n\":\"");
								titleJson.append(map.get("NAME"));
								titleJson.append("\"}");
							}
						}
						titleJson.append("]");
					}
					if ("Q".equals(cqmUseCol.getColType())) {
						titleJson.append(",\"cc\":[");
						List list = cqmIndexDomain.getSectionIndexData(cqmUseCol.getIndexId());
						CqmIndex index = cqmIndexDomain.get(cqmUseCol.getIndexId());
						if("1".equals(index.getIfSum())){
							titleJson.append("{\"c\":\""+cqmUseCol.getColId()+"CODE");
							titleJson.append("\",\"n\":\"合计");
							titleJson.append("\"}");
						}
						for (int k = 0; k < list.size(); k++) {
							Map map = (Map) list.get(k);
							if("1".equals(index.getIfSum())){
								titleJson.append(",");
								titleJson.append("{\"c\":\"");
								titleJson.append(cqmUseCol.getColId());
								titleJson.append(map.get("SECTION_ID"));
								titleJson.append("\",\"n\":\"");
								titleJson.append(map.get("SECTION_NAME"));
								titleJson.append("\"}");
							}else{
								if (k != 0) {
									titleJson.append(",");
								}
								titleJson.append("{\"c\":\"");
								titleJson.append(cqmUseCol.getColId());
								titleJson.append(map.get("SECTION_ID"));
								titleJson.append("\",\"n\":\"");
								titleJson.append(map.get("SECTION_NAME"));
								titleJson.append("\"}");
							}
						}
						titleJson.append("]");
					}
					titleJson.append("}");
					cqmUseColDomain.insert(cqmUseCol);
				}
			}
			
			titleJson.append("]}");
		}
		titleJson.append("]}");
		
		cqmReport.setReportTitle(titleJson.toString());
		cqmReportDao.update(cqmReport);
	}

	public DataSet queryReport(ParameterSet pset) {
		return cqmReportDao.queryReport(pset);
	}

	public DataSet getReportLayeredRow(String organCode,boolean ifUnder) {
		return cqmReportDao.getReportLayeredRow(organCode,ifUnder);
	}

	public DataSet getReportLayeredData(String organCode, CqmUseCol cqmUseCol,List cqmUseSearchList) {
		CqmUseView userUseView = cqmUseViewDomain.get(cqmUseCol.getReportId(),cqmUseCol.getViewId());
		if("Q".equals(cqmUseCol.getColType())){
			List sections = cqmIndexDomain.getSectionIndexData(cqmUseCol.getIndexId());
			return cqmReportDao.getReportLayeredData(organCode,cqmUseCol,sections,userUseView, cqmUseSearchList);
		}else{
			return cqmReportDao.getReportLayeredData(organCode,cqmUseCol,userUseView, cqmUseSearchList);
		}
		
	}

	public void updateUseConditions(String reportId, String viewId,
			List<CqmUseCondition> conditions) {
		cqmUseConditionDomain.deleteByReportIdViewId(reportId, viewId);
		for (int i =0;i<conditions.size();i++) {
			CqmUseCondition condition = conditions.get(i);
			condition.setConditionId(IdHelp.getUUID32());
			condition.setReportId(reportId);
			condition.setViewId(viewId);
			condition.setColId("col_id"+i);
			cqmUseConditionDomain.insert(condition);
		}
	}

}