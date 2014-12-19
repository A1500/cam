package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.DisabilityIdentification;
import com.inspur.cams.bpt.base.domain.IDisabilityIdentificationDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * @title:DisabilityIdentificationQueryCommand
 * @description:伤残鉴定介绍信
 * @author:
 * @since:2011-05-18
 * @version:1.0
 */
public class DisabilityIdentificationQueryCommand extends BaseQueryCommand {
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	/**
	 * 获得伤残鉴定介绍信服务接口
	 */
	private IDisabilityIdentificationDomain identiService = ScaComponentFactory
			.getService(IDisabilityIdentificationDomain.class,
					"disabilityIdentificationDomain/disabilityIdentificationDomain");

	@SuppressWarnings("unchecked")
	@Trans
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		String peopleId = (String) getParameter("PEOPLE_ID");
		String applyId = (String) getParameter("APPLY_ID");
		DataSet identiDataSet = identiService.query(pset);
		if (identiDataSet.getCount() > 0) {// 存在，查询出其记录
			Record identiRecord = identiDataSet.getRecord(0);
			identiDataSet.addField("domicileName");

			EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
					.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");

			// 获取domicileName
			String domicileCode = identiRecord.get("domicileCode").toString();
			pset.clear();
			pset.setParameter("ID", domicileCode);
			DataSet domicileCodeDataSet = dao.query(pset);
			Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
			String domicileName = domicileCodeRecord.get("name").toString();

			identiRecord.set("domicileName", domicileName);

			return new DataSet(identiRecord);
		} else {// 不存在，在数据库中插入一条记录并返回当前记录
			pset.clear();
			pset.setParameter("PEOPLE_ID", peopleId);
			Record peopleRd = service.queryPeople(pset).getRecord(0);
			Record disabilityRd = service.queryDisabilityInfo(pset)
					.getRecord(0);
			DisabilityIdentification disIndentiIntro = new DisabilityIdentification();
			disIndentiIntro.setApplyId(applyId);
			disIndentiIntro.setPeopleId(peopleId);
			disIndentiIntro.setName(peopleRd.get("name").toString());
			disIndentiIntro.setSex(peopleRd.get("sex").toString());
			disIndentiIntro.setBirthday(peopleRd.get("birthday").toString());
			disIndentiIntro.setDomicileCode(peopleRd.get("domicileCode")
					.toString());
			disIndentiIntro.setIdCard(peopleRd.get("idCard").toString());
			if (peopleRd.get("address") != null) {
				disIndentiIntro.setAddress(peopleRd.get("address").toString());
			}
			if (peopleRd.get("workUnitName") != null) {
				disIndentiIntro.setWorkUnitName(peopleRd.get("workUnitName")
						.toString());
			}
			if (disabilityRd.get("disabilityDate") != null) {
				disIndentiIntro.setDisabilityDate(disabilityRd.get(
						"disabilityDate").toString());
			}
			if (disabilityRd.get("disabilityReason") != null) {
				disIndentiIntro.setDisabilityReason(disabilityRd.get(
						"disabilityReason").toString());
			}
			if (disabilityRd.get("disabilityBody") != null) {
				disIndentiIntro.setDisabilityBody(disabilityRd.get(
						"disabilityBody").toString());
			}
			identiService.insert(disIndentiIntro);// 插入一条记录

			// 返回DataSet
			DataSet ds = identiService.query(pset);
			ds.addField("domicileName");
			Record rd = ds.getRecord(0);
			EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
					.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			// 获取domicileName
			String domicileCode = peopleRd.get("domicileCode").toString();
			pset.clear();
			pset.setParameter("ID", domicileCode);
			DataSet domicileCodeDataSet = dao.query(pset);
			Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
			String domicileName = domicileCodeRecord.get("name").toString();
			rd.set("domicileName", domicileName);
			return new DataSet(rd);
		}
	}
	@Trans
	public DataSet introductionSave() {
		ParameterSet pset = getParameterSet();
		String applyId = (String) getParameter("APPLY_ID");
		String peopleId = (String) getParameter("PEOPLE_ID");
		DataSet identiDataSet = identiService.query(pset);
		if (identiDataSet.getCount() > 0) {// 存在，查询出其记录
			Record identiRecord = identiDataSet.getRecord(0);
			identiDataSet.addField("domicileName");

			EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
					.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");

			// 获取domicileName
			String domicileCode = identiRecord.get("domicileCode").toString();
			pset.clear();
			pset.setParameter("ID", domicileCode);
			DataSet domicileCodeDataSet = dao.query(pset);
			Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
			String domicileName = domicileCodeRecord.get("name").toString();

			identiRecord.set("domicileName", domicileName);

			return new DataSet(identiRecord);
		} else {// 不存在，在数据库中插入一条记录并返回当前记录
			pset.clear();
			pset.setParameter("PEOPLE_ID", peopleId);
			Record peopleRd = service.queryPeople(pset).getRecord(0);
			DisabilityIdentification disIndentiIntro = new DisabilityIdentification();
			disIndentiIntro.setApplyId(applyId);
			disIndentiIntro.setPeopleId(peopleId);
			disIndentiIntro.setName(peopleRd.get("name").toString());
			disIndentiIntro.setSex(peopleRd.get("sex").toString());
			disIndentiIntro.setBirthday(peopleRd.get("birthday").toString());
			disIndentiIntro.setDomicileCode(peopleRd.get("domicileCode")
					.toString());
			disIndentiIntro.setIdCard(peopleRd.get("idCard").toString());
			if (peopleRd.get("address") != null) {
				disIndentiIntro.setAddress(peopleRd.get("address").toString());
			}
			if (peopleRd.get("workUnitName") != null) {
				disIndentiIntro.setWorkUnitName(peopleRd.get("workUnitName")
						.toString());
			}
			identiService.insert(disIndentiIntro);// 插入一条记录

			// 返回DataSet
			DataSet ds = identiService.query(pset);
			ds.addField("domicileName");
			Record rd = ds.getRecord(0);
			EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
					.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			// 获取domicileName
			String domicileCode = peopleRd.get("domicileCode").toString();
			pset.clear();
			pset.setParameter("ID", domicileCode);
			DataSet domicileCodeDataSet = dao.query(pset);
			Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
			String domicileName = domicileCodeRecord.get("name").toString();
			rd.set("domicileName", domicileName);
			return new DataSet(rd);
		}

	}
}
