package com.inspur.cams.fis.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisCertCremation;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisCertCremationDao
 * @Description: TODO 殡葬业务火化证明表Dao的接口
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public interface IFisCertCremationDao extends BaseCURD<FisCertCremation> {
	public void save(List<FisCertCremation> list);

	/**
	 * @Title: queryForCremationCretList
	 * @Description: TODO(领灰证明列表查询方法)
	 * @param
	 * @param pset
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 */
	public DataSet queryForCremationCretList(ParameterSet pset);

	public DataSet queryCompleteHistory(ParameterSet pset);

	/**
	 * @Title: queryCremationCertBriefInfo
	 * @Description: TODO(火化证明概要信息)
	 * @return DataSet
	 * @param pset
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryCremationCertBriefInfo(ParameterSet pset);

	/**
	 * @Title: printCremationCertAfter
	 * @Description: TODO(打印火化证明成功后操作) void
	 * @param pset
	 * @throws
	 * @author luguosui
	 */
	public void printCremationCertAfter(ParameterSet pset);

	/**
	 * @Title: queryCremationCertMsg
	 * @Description: TODO(查询当前火化证明信息)
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryCremationCertMsg(ParameterSet pset);

	/**
	 * @Title: queryCertInfoAndCustomInfo
	 * @Description: TODO(打印历史证明信息查询)
	 * @author wangziming
	 */
	public DataSet queryCertInfoAndCustomInfo(ParameterSet pset);

	public DataSet queryForExport(ParameterSet set);
}
