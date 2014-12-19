package com.inspur.cams.fis.base.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.fis.base.dao.IFisResourceExtendDao;
import com.inspur.cams.fis.base.dao.IFisResourceInfoDao;
import com.inspur.cams.fis.base.data.FisResourceExtend;
import com.inspur.cams.fis.base.data.FisResourceInfo;
import com.inspur.cams.fis.base.domain.IFisResourceInfoDomain;
import com.inspur.cams.fis.util.BspUtil;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisResourceInfoDomain
 * @Description: TODO 殡葬业务资源表domain实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceInfoDomain implements IFisResourceInfoDomain {

	@Reference
	private IFisResourceInfoDao fisResourceInfoDao;
	@Reference
	private IFisResourceExtendDao fisResourceExtendDao;

	public DataSet query(ParameterSet pset) {
		return fisResourceInfoDao.query(pset);
	}

	public DataSet checkChildDisenableUse(ParameterSet pset) {
		return fisResourceInfoDao.checkChildDisenableUse(pset);
	}

	/**
	 * 联合特征扩展表查询
	 * 
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithExtend(ParameterSet pset) {
		DataSet ds = fisResourceInfoDao.queryWithExtend(pset);
		return ds;
	}

	/**
	 * 通过安葬申请表的墓穴位置 联合特征扩展表、墓价规则表查询
	 * 
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithPriceByBury(ParameterSet pset) {
		DataSet ds = fisResourceInfoDao.queryWithPriceByBury(pset);
		return ds;
	}

	/**
	 * 联合特征扩展表、墓价规则表查询
	 * 
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithPrice(ParameterSet pset) {
		DataSet ds = fisResourceInfoDao.queryWithPrice(pset);
		return ds;
	}

	public DataSet queryForMess(ParameterSet pset) {
		return fisResourceInfoDao.queryForMess(pset);
	}

	@Trans
	public DataSet queryForService(ParameterSet pset) {
		return fisResourceInfoDao.queryForService(pset);
	}

	@Trans
	public DataSet queryForStatistics(ParameterSet pset) {
		return fisResourceInfoDao.queryForStatistics(pset);
	}

	@Trans
	public void insert(FisResourceInfo fisResourceInfo) {
		fisResourceInfoDao.insert(fisResourceInfo);
	}

	/**
	 * @author mq
	 */
	@Trans
	public void insertWithExtend(FisResourceInfo fisResourceInfo) {
	}

	@Trans
	public void batchInsert(List<FisResourceInfo> list) {
	}

	/**
	 * @author mq
	 */
	@Trans
	public void batchInsertWithExtend(List<FisResourceInfo> list) {
	}

	@Trans
	public void update(FisResourceInfo fisResourceInfo) {
	}

	/**
	 * @author mq
	 */
	@Trans
	public void updateWithExtend(FisResourceInfo fisResourceInfo) {
	}

	@Trans
	public void updateWithPrice(FisResourceInfo fisResourceInfo) {
	}

	@Trans
	public void batchUpdate(List<FisResourceInfo> list) {
	}

	@Trans
	public void delete(String[] delIds) {
	}

	@Trans
	public String deleteFisResourceInfoWithExtend(ParameterSet pset) {
		return fisResourceInfoDao.deleteFisResourceInfoWithExtend(pset);
	}

	@Trans
	public void save(List<FisResourceInfo> list) {
	}

	public BigDecimal getLastLevelMaxNum(ParameterSet pset) {
		return fisResourceInfoDao.getLastLevelMaxNum(pset);
	}

	/**
	 * 修改资源状态
	 */
	@Trans
	public void changeResourceStatus(ParameterSet pset) {
	}

	/**
	 * 检验资源状态
	 * 
	 * @param pset
	 * @return 1：操作成功,0:操作失败
	 */
	public int updateResource(ParameterSet pset) {
		String resourceId = (String) pset.get("resource_Id");
		int state = (Integer) pset.get("state");
		String status = (String) pset.get("status");
		BigDecimal useNum = (BigDecimal) pset.get("useNum");
		pset.clear();
		pset.setParameter("resource_Id", resourceId);
		if (StringUtils.isNotEmpty(resourceId)) {
			DataSet ds = fisResourceInfoDao.query(pset);
			if (ds == null) {
				return 0;
			}
			if (ds.getCount() == 0) {
				return 0;
			}
			FisResourceInfo dataBean = checkResource((FisResourceInfo) ds.getRecord(0).toBean(FisResourceInfo.class), state);
			if (StringUtils.isNotEmpty(status)) {
				dataBean.setStatus(status);
			}
			if (useNum != null) {
				dataBean.setUseNum(useNum);
			}
			fisResourceInfoDao.update(dataBean);
			return 1;
		}
		return 0;
	}

	public int dealResource(String resourceId, int status) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("resource_Id", resourceId);
		if (StringUtils.isNotEmpty(resourceId)) {
			DataSet ds = fisResourceInfoDao.query(pset);
			if (ds == null) {
				return 0;
			}
			if (ds.getCount() == 0) {
				return 0;
			}
			FisResourceInfo dataBean = (FisResourceInfo) ds.getRecord(0).toBean(FisResourceInfo.class);
			fisResourceInfoDao.update(checkResource(dataBean, status));
			return 1;

		}
		return 0;

	}

	/**
	 * 根据请求状态处理资源Bean
	 * 
	 * @param dataBean
	 * @param state
	 * @return
	 */
	public FisResourceInfo checkResource(FisResourceInfo dataBean, int state) {
		BigDecimal useNum = dataBean.getUseNum();
		BigDecimal maxUseNum = dataBean.getMaxUseNum();
		BigDecimal one = new BigDecimal(1);
		int resoult = one.compareTo(maxUseNum.subtract(useNum));
		if (dataBean.STATE_NEW == state) {
			// 新增格位使用
			if (resoult == 0) {
				// 只剩一个使用数量
				dataBean.setStatus("2");
				dataBean.setUseNum(maxUseNum);
			} else if (resoult == -1) {
				// 剩多个使用数量
				dataBean.setStatus("1");
				dataBean.setUseNum(useNum.add(new BigDecimal(1)));
			}
		}
		if (dataBean.STATE_DELETED == state) {
			// -取消格位使用
			if (one.compareTo(maxUseNum) == 0) {// 最大使用数量是1
				if (one.compareTo(useNum) == 0) {// 已使用的数量是1
					dataBean.setStatus("0");
					dataBean.setUseNum(new BigDecimal(0));
				} else {

				}
			} else if (one.compareTo(maxUseNum) == -1) {
				// 最大使用数量大于1
				if (one.compareTo(useNum) == 0) {// 已使用的数量是1
					dataBean.setStatus("0");
					dataBean.setUseNum(new BigDecimal(0));
				} else if (one.compareTo(useNum) == -1) {// 已使用数量大于1
					dataBean.setStatus("1");
					dataBean.setUseNum(useNum.subtract(one));
				}

			}
		}

		return dataBean;
	}

	/**
	 * @Title: beingLevelAndRule
	 * @Description: TODO(可分级的类别，是否定义级别和规则)
	 * @param
	 * @return void
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet beingLevelAndRule(ParameterSet pset) {
		return fisResourceInfoDao.beingLevelAndRule(pset);
	}

	/**
	 * @Title: executeForCemeteryUsing
	 * @Description: TODO(墓穴使用情况统计)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet executeForCemeteryUsing(ParameterSet pset) {
		return fisResourceInfoDao.executeForCemeteryUsing(pset);
	}

	/**
	 * @author mq
	 */
	public void deleteWithExtend(ParameterSet pset) {
		String resourceId = (String) pset.getParameter("resourceId");
		fisResourceInfoDao.delete(resourceId);
		pset.clear();
		pset.setParameter("RESOURCE_ID", resourceId);
		DataSet ds = fisResourceExtendDao.query(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			fisResourceExtendDao.delete(ds.getRecord(i).get("recordId"));
		}
	}

	public DataSet queryForExport(ParameterSet set) {
		return fisResourceInfoDao.queryForExport(set);
	}

}