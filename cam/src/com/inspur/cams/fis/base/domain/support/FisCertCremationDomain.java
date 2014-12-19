package com.inspur.cams.fis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.fis.base.dao.IFisCertCremationDao;
import com.inspur.cams.fis.base.data.FisCertCremation;
import com.inspur.cams.fis.base.domain.IFisCertCremationDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisCertCremationDomain
 * @Description: TODO 殡葬业务火化证明表Domain的实现
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisCertCremationDomain implements IFisCertCremationDomain {

	@Reference
	private IFisCertCremationDao fisCertCremationDao;

	public void delete(String[] delIds) {
		// TODO Auto-generated method stub
		fisCertCremationDao.batchDelete(delIds);
	}

	public void insert(FisCertCremation bean) {
		// TODO Auto-generated method stub
		fisCertCremationDao.insert(bean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return fisCertCremationDao.query(pset);
	}

	public void save(List<FisCertCremation> list) {
		// TODO Auto-generated method stub
		fisCertCremationDao.save(list);
	}

	public void update(FisCertCremation bean) {
		// TODO Auto-generated method stub
		fisCertCremationDao.update(bean);
	}

	/**
	 * @Title: queryForCremationCretList
	 * @Description: TODO(领灰证明列表查询方法)
	 * @param
	 * @param pset
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 */
	public DataSet queryForCremationCretList(ParameterSet pset) {
		return fisCertCremationDao.queryForCremationCretList(pset);

	}

	public void insertAndUpdate(FisCertCremation bean) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("DEAD_ID", bean.getDeadId());
		pset.setParameter("CERT_STATUS", "1");
		DataSet ds = fisCertCremationDao.query(pset);
		FisCertCremation dataBean = new FisCertCremation();
		if (ds.getCount() > 0) {
			dataBean = (FisCertCremation) ds.getRecord(0).toBean(FisCertCremation.class);
			dataBean.setCertStatus("0");
		}
		fisCertCremationDao.update(dataBean);

		fisCertCremationDao.insert(bean);

	}

	public DataSet queryCompleteHistory(ParameterSet pset) {
		// TODO Auto-generated method stub
		return fisCertCremationDao.queryCompleteHistory(pset);
	}

	public void updateByCertId(ParameterSet pset) {
		String certId = pset.getParameter("certId") == null ? "" : (String) pset.getParameter("certId");
		String method = pset.getParameter("method") == null ? "" : (String) pset.getParameter("method");
		ParameterSet localPset = new ParameterSet();
		localPset.setParameter("CERT_ID", certId);
		DataSet ds = fisCertCremationDao.query(localPset);
		if (ds.getCount() > 0) {
			FisCertCremation dataBean = (FisCertCremation) ds.getRecord(0).toBean(FisCertCremation.class);
			dataBean.setIfIssue("1");// 发放火化证明
			dataBean.setIssueTime(DateUtil.getTime());
			if ("AGAIN".equals(method)) {
				String deadId = dataBean.getDeadId();
				localPset.clear();
				localPset.setParameter("DEAD_ID", deadId);
				localPset.setParameter("CERT_STATUS", "1");
				DataSet ds2 = fisCertCremationDao.query(localPset);
				FisCertCremation dataBean2 = new FisCertCremation();
				if (ds2.getCount() > 0) {
					dataBean2 = (FisCertCremation) ds2.getRecord(0).toBean(FisCertCremation.class);
					dataBean2.setCertStatus("0");
				}
				fisCertCremationDao.update(dataBean2);

				dataBean.setCertStatus("1");
				fisCertCremationDao.update(dataBean);

			} else {
				fisCertCremationDao.update(dataBean);
			}
		}
	}

	/**
	 * @Title: queryCremationCertBriefInfo
	 * @Description: TODO(火化证明概要信息)
	 * @return DataSet
	 * @param pset
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryCremationCertBriefInfo(ParameterSet pset) {
		return fisCertCremationDao.queryCremationCertBriefInfo(pset);
	}

	/**
	 * @Title: printCremationCertAfter
	 * @Description: TODO(打印火化证明成功后操作) void
	 * @param pset
	 * @throws
	 * @author luguosui
	 */
	public void printCremationCertAfter(ParameterSet pset) {
		fisCertCremationDao.printCremationCertAfter(pset);

	}

	/**
	 * @Title: queryCremationCertMsg
	 * @Description: TODO(查询当前火化证明信息)
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryCremationCertMsg(ParameterSet pset) {
		// TODO Auto-generated method stub
		return fisCertCremationDao.queryCremationCertMsg(pset);
	}

	/**
	 * @Title: queryCertInfoAndCustomInfo
	 * @Description: TODO(打印历史证明信息查询)
	 * @author wangziming
	 */
	public DataSet queryCertInfoAndCustomInfo(ParameterSet pset) {
		// TODO Auto-generated method stub
		return fisCertCremationDao.queryCertInfoAndCustomInfo(pset);
	}

	public DataSet queryForExport(ParameterSet set) {
		return fisCertCremationDao.queryForExport(set);
	}
}
