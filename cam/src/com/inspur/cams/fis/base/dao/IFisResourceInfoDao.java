package com.inspur.cams.fis.base.dao;

import java.math.BigDecimal;
import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisResourceInfo;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisResourceInfoDao
 * @Description: TODO 殡葬业务资源表dao接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisResourceInfoDao extends BaseCURD<FisResourceInfo> {
	public void save(List<FisResourceInfo> list);

	public DataSet queryForService(ParameterSet pset);

	public BigDecimal getLastLevelMaxNum(ParameterSet pset);

	public DataSet queryForStatistics(ParameterSet pset);

	public DataSet queryWithExtend(ParameterSet pset);

	public DataSet queryWithPrice(ParameterSet pset);

	/**
	 * 通过安葬申请表的墓穴位置 联合特征扩展表、墓价规则表查询
	 * 
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithPriceByBury(ParameterSet pset);

	public DataSet checkChildDisenableUse(ParameterSet pset);

	/**
	 * 修改资源状态
	 */
	public void changeResourceStatus(ParameterSet pset);

	/**
	 * @Title: beingLevelAndRule
	 * @Description: TODO(可分级的类别，是否定义级别和规则)
	 * @param
	 * @return void
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet beingLevelAndRule(ParameterSet pset);

	/**
	 * @Title: queryForMess
	 * @Description: TODO(查询格位的相关信息)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queryForMess(ParameterSet pset);

	/**
	 * @Title: executeForCemeteryUsing
	 * @Description: TODO(墓穴使用情况统计)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet executeForCemeteryUsing(ParameterSet pset);

	/**
	 * @author mq
	 * @param pset
	 * @return
	 */
	public String deleteFisResourceInfoWithExtend(ParameterSet pset);

	public DataSet queryForExport(ParameterSet set);
}
