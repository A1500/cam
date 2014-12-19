package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.base.data.FisCertCremation;
import com.inspur.cams.fis.base.domain.IFisCertCremationDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisCertCremationCmd
 * @Description: TODO 殡葬业务火化证明表Cmd
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisCertCremationCmd extends BaseAjaxCommand {
	IFisCertCremationDomain service = ScaComponentFactory.getService(IFisCertCremationDomain.class, "FisCertCremationDomain/FisCertCremationDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		FisCertCremation dataBean = (FisCertCremation) record.toBean(FisCertCremation.class);
		service.insert(dataBean);
	}

	public void update() {
		Record[] records = (Record[]) getParameter("records");
		if (records != null && !".".equals(records) && records.length > 0) {
			FisCertCremation dataBean = (FisCertCremation) records[0].toBean(FisCertCremation.class);
			service.update(dataBean);
		}
	}

	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		service.delete(delIds);
	}

	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		if (records != null && !".".equals(records) && records.length > 0) {
			FisCertCremation dataBean = (FisCertCremation) records[0].toBean(FisCertCremation.class);
			// 设置主键
			// String certId=FisIdHelp.getRecordCode();
			// dataBean.setCertId(certId);
			service.insert(dataBean);
		}
		// List<FisCertCremation> list = new ArrayList<FisCertCremation>();
		// for (int i = 0; i < records.length; i++) {
		// // convert record to entity bean
		// FisCertCremation dataBean = (FisCertCremation) records[i].toBean(FisCertCremation.class);
		// list.add(dataBean);
		// }
		// service.save(list);
	}

	/**
	 * 殡葬业务火化证明表
	 */
	public void queryForCertId() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.query(pset);
		String certId = "";
		if (ds.getCount() > 0) {
			FisCertCremation dataBean = (FisCertCremation) ds.getRecord(0).toBean(FisCertCremation.class);
			certId = dataBean.getCertId();
		}
		setReturn("certId", certId);
	}

	/**
	 * 殡葬业务火化证明表
	 */
	public void insertAndUpdate() {
		Record record = (Record) getParameter("record");
		FisCertCremation dataBean = (FisCertCremation) record.toBean(FisCertCremation.class);
		service.insertAndUpdate(dataBean);
	}

	/**
	 * @Title: updateByCertId
	 * @Description: TODO(根据主键更新火化证明信息)
	 * @param
	 * @return void
	 * @throws
	 * @author jiangzhaobao
	 */
	public void updateByCertId() {
		ParameterSet pset = getParameterSet();
		service.updateByCertId(pset);
	}

	/**
	 * @Title: printCremationCertAfter
	 * @Description: TODO(打印火化证明成功后操作) void
	 * @throws
	 * @author luguosui
	 */
	public void printCremationCertAfter() {
		ParameterSet pset = getParameterSet();
		service.printCremationCertAfter(pset);
	}
}
