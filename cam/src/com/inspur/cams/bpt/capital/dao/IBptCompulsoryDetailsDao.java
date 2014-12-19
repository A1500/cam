package com.inspur.cams.bpt.capital.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.capital.data.BptCompulsoryDetails;

/**
 * @title:优待金发放发放名册 Dao 层 接口
 * @description:
 */
public interface IBptCompulsoryDetailsDao extends BaseCURD<BptCompulsoryDetails>{
	 public void save(List<BptCompulsoryDetails> list);
	 
	/**
	 * 查询义务兵优待金发放列表
	 */
	public DataSet queryCompulsoryGrantList(ParameterSet pset);
	
	/**
	 * 除义务兵家庭外其他优抚对象优待金发放添加生成明细
	 */
	public void queryNonCompulsoryGenerateData(ParameterSet pset);
	
	/**
	 * 新增优待金（非义务兵）发放对象
	 */
	public DataSet getNewCompulsoryGrantObject(ParameterSet pset);
	
	/**
	 * 优待金修改数据集
	 */
	public DataSet queryCompulsoryUpdate(ParameterSet pset);
	 
}