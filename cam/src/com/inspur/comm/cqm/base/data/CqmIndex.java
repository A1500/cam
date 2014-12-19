package com.inspur.comm.cqm.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

import com.inspur.cams.comm.util.BspUtil;

/**
 * 自定义统计报表指标表databean
 * @author shgtch
 * @date 2012-03-16
 */
@Table(tableName = "CQM_INDEX", keyFields = "indexId")
public class CqmIndex extends StatefulDatabean {

	// 指标内码
	private String indexId;

	// 指标名称
	private String name;

	// 指标代码字段
	private String indexCode;

	// 指标名称字段
	private String indexName;

	// 指标逻辑
	private String indexLogic;

	// 作为行是否一次性加载
	private String ifLoadOnce;

	//是否有合计
	private String ifSum;

	// 行总数
	@Transient
	private BigDecimal rowCount;

	// 开始条数
	@Transient
	private String start;

	// 结束条数
	@Transient
	private String end;


	/**
	 * 获取 指标内码
	 * @return String
	 */
	public String getIndexId() {
		return indexId;
	}

	/**
	 * 设置 指标内码
	 */
	public void setIndexId(String indexId) {
		this.indexId = indexId;
	}

	/**
	 * 获取 指标名称
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 指标名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取 指标代码字段
	 * @return String
	 */
	public String getIndexCode() {
		return indexCode;
	}

	/**
	 * 设置 指标代码字段
	 */
	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	/**
	 * 获取 指标名称字段
	 * @return String
	 */
	public String getIndexName() {
		return indexName;
	}

	/**
	 * 设置 指标名称字段
	 */
	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	/**
	 * 获取 指标逻辑
	 * @return String
	 */
	public String getIndexLogic() {
		return indexLogic;
	}
	/**
	 * 获取 指标逻辑行政区划过滤
	 * @return String
	 */
	public String getIndexLogicFilter() {
		if(indexLogic.indexOf("&")>0){
			indexLogic=indexLogic.replace("&", " ");
			String organCode = BspUtil.getOrganCode().substring(0,6);
			indexLogic+="'"+organCode+"%'";
		}
		return indexLogic;
	}

	/**
	 * 设置 指标逻辑
	 */
	public void setIndexLogic(String indexLogic) {
		this.indexLogic = indexLogic;
	}

	/**
	 * 获取 作为行是否一次性加载
	 * @return
	 */
	public String getIfLoadOnce() {
		return ifLoadOnce;
	}

	/**
	 * 设置 作为行是否一次性加载
	 * @param ifLoadOnce
	 */
	public void setIfLoadOnce(String ifLoadOnce) {
		this.ifLoadOnce = ifLoadOnce;
	}

	public BigDecimal getRowCount() {
		return rowCount;
	}

	public void setRowCount(BigDecimal rowCount) {
		this.rowCount = rowCount;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getIfSum() {
		return ifSum;
	}

	public void setIfSum(String ifSum) {
		this.ifSum = ifSum;
	}

}