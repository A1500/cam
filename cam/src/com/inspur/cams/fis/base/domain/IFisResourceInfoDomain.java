package com.inspur.cams.fis.base.domain;

import java.math.BigDecimal;
import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisResourceInfo;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisResourceInfoDomain
 * @Description: TODO 殡葬业务资源表domain接口
 * @author wangziming-muqi
 * @date 2011-11-15
 */
public interface IFisResourceInfoDomain {

	public DataSet query(ParameterSet pset);

	/**
	 * 联合特征扩展表查询
	 * 
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithExtend(ParameterSet pset);

	/**
	 * 联合特征扩展表、墓价规则表查询
	 * 
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithPrice(ParameterSet pset);

	/**
	 * 通过安葬申请表的墓穴位置 联合特征扩展表、墓价规则表查询
	 * 
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithPriceByBury(ParameterSet pset);

	/**
	 * @Title: queryForMess
	 * @Description: TODO(查询格位的相关信息)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queryForMess(ParameterSet pset);

	public DataSet queryForService(ParameterSet pset);

	public DataSet queryForStatistics(ParameterSet pset);

	/**
	 * @author mq
	 * @param pset
	 * @return
	 */
	public DataSet checkChildDisenableUse(ParameterSet pset);

	@Trans
	public void insert(FisResourceInfo fisResourceInfo);

	/**
	 * @author mq
	 * @param fisResourceInfo
	 */
	@Trans
	public void insertWithExtend(FisResourceInfo fisResourceInfo);

	@Trans
	public void batchInsert(List<FisResourceInfo> list);

	/**
	 * @author mq
	 * @param list
	 */
	@Trans
	public void batchInsertWithExtend(List<FisResourceInfo> list);

	@Trans
	public void update(FisResourceInfo fisResourceInfo);

	/**
	 * @author mq
	 * @param fisResourceInfo
	 */
	@Trans
	public void updateWithExtend(FisResourceInfo fisResourceInfo);

	/**
	 * @author mq
	 * @param fisResourceInfo
	 */
	@Trans
	public void updateWithPrice(FisResourceInfo fisResourceInfo);

	@Trans
	public void batchUpdate(List<FisResourceInfo> list);

	@Trans
	public void delete(String[] delIds);

	@Trans
	public void deleteWithExtend(ParameterSet pset);

	@Trans
	public String deleteFisResourceInfoWithExtend(ParameterSet pset);

	@Trans
	public void save(List<FisResourceInfo> list);

	@Trans
	public BigDecimal getLastLevelMaxNum(ParameterSet pset);

	/**
	 * 修改资源状态
	 */
	@Trans
	public void changeResourceStatus(ParameterSet pset);

	public int dealResource(String resourceId, int status);

	/**
	 * 检验资源状态
	 * 
	 * @param pset
	 * @return 1：操作成功,0:操作失败
	 */
	public int updateResource(ParameterSet pset);

	/**
	 * 根据请求状态处理资源Bean
	 * 
	 * @param dataBean
	 * @param state
	 * @return
	 */
	public FisResourceInfo checkResource(FisResourceInfo dataBean, int state);

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
	 * @Title: executeForCemeteryUsing
	 * @Description: TODO(墓穴使用情况统计)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet executeForCemeteryUsing(ParameterSet pset);

	public DataSet queryForExport(ParameterSet set);
}