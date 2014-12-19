package com.inspur.cams.bpt.capital.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.capital.data.BptCompulsoryDetails;

/**
 * @title:优待金发放Domain层接口
 */
public interface IBptCompulsoryDetailsDomain {
	
	/**
	 * 查询义务兵优待金明细
	 */
	public DataSet queryCompulDetail(ParameterSet pset);
	
	/**
	 * 添加义务兵优待金明细
	 */
	public void addCompulDetail(BptCompulsoryDetails compulsoryDetails);
	
	/**
	 * 修改义务兵优待金明细
	 */
	public void updateCompulDetail(BptCompulsoryDetails compulsoryDetails);
	
	/**
	 * 查询义务兵优待金发放列表
	 */
	public DataSet queryCompulsoryGrantList(ParameterSet pset);
	
	/**
	 * 删除义务兵优待金发放记录
	 */
	public void deleteCompulsoryDetail(String[] delIds);
	
	/**
	 * 除义务兵家庭外其他优抚对象优待金发放添加生成明细
	 */
	public void queryNonCompulsoryGenerateData(ParameterSet pset);
	
	/**
	 * 批量添加除义务兵家庭外其他优抚对象优待金发放
	 */
	public void batchAddOfNonCompulsory(List<BptCompulsoryDetails> list);
	
	/**
	 * 批量更新除义务兵家庭外其他优抚对象优待金
	 */
	public void batchUpdateNonCompulsory(List<BptCompulsoryDetails> list);
	
	/**
	 * 新增优待金（非义务兵）发放对象
	 */
	public DataSet getNewCompulsoryGrantObject(ParameterSet pset);
	
	/**
	 * query方法
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 优待金修改数据集
	 */
	public DataSet queryCompulsoryUpdate(ParameterSet pset);
}
