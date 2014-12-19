package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.fis.base.dao.IFisFuneralOrganDao;
import com.inspur.cams.fis.base.data.FisFuneralOrgan;
import com.inspur.cams.fis.util.FisIdHelp;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisFuneralOrganDao
 * @Description: TODO 殡葬业务殡仪馆信息表dao的实现
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisFuneralOrganDao extends EntityDao<FisFuneralOrgan> implements IFisFuneralOrganDao {

	public FisFuneralOrganDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisFuneralOrgan.class;
	}

	@Override
	public FisFuneralOrgan insert(FisFuneralOrgan dataBean) {
		dataBean.setCreateOrgan(FisIdHelp.getFisOrganCode(FisIdHelp.FIS_ORGAN_FH));
		dataBean.setCreateOrganName(FisIdHelp.getFisOrganName(FisIdHelp.FIS_ORGAN_FH));
		dataBean.setCreatePeople(BspUtil.getEmpOrgan().getOrganId());
		dataBean.setCreatePeopleName(BspUtil.getEmpOrgan().getOrganName());
		dataBean.setCreateTime(DateUtil.getTime());
		return super.insert(dataBean);
	}

	@Override
	public FisFuneralOrgan update(FisFuneralOrgan dataBean) {
		dataBean.setCreateOrgan(FisIdHelp.getFisOrganCode(FisIdHelp.FIS_ORGAN_FH));
		dataBean.setCreateOrganName(FisIdHelp.getFisOrganName(FisIdHelp.FIS_ORGAN_FH));
		dataBean.setCreatePeople(BspUtil.getEmpOrgan().getOrganId());
		dataBean.setCreatePeopleName(BspUtil.getEmpOrgan().getOrganName());
		dataBean.setCreateTime(DateUtil.getTime());
		return super.update(dataBean);
	}

	@Override
	public void batchInsert(List<FisFuneralOrgan> arg0) {
		String fisOrganCode = FisIdHelp.getFisOrganCode(FisIdHelp.FIS_ORGAN_FH);
		String fisOrganName = FisIdHelp.getFisOrganName(FisIdHelp.FIS_ORGAN_FH);
		String empOrganId = BspUtil.getEmpOrgan().getOrganId();
		String empOrganName = BspUtil.getEmpOrgan().getOrganName();
		String lastTimes = DateUtil.getTime();

		for (int i = 0; i < arg0.size(); i++) {
			FisFuneralOrgan dataBean = arg0.get(i);
			dataBean.setCreateOrgan(fisOrganCode);
			dataBean.setCreateOrganName(fisOrganName);
			dataBean.setCreatePeople(empOrganId);
			dataBean.setCreatePeopleName(empOrganName);
			dataBean.setCreateTime(lastTimes);
		}
		super.batchInsert(arg0);
	}

	@Override
	public void batchUpdate(List<FisFuneralOrgan> arg0) {
		String fisOrganCode = FisIdHelp.getFisOrganCode(FisIdHelp.FIS_ORGAN_FH);
		String fisOrganName = FisIdHelp.getFisOrganName(FisIdHelp.FIS_ORGAN_FH);
		String empOrganId = BspUtil.getEmpOrgan().getOrganId();
		String empOrganName = BspUtil.getEmpOrgan().getOrganName();
		String lastTimes = DateUtil.getTime();

		for (int i = 0; i < arg0.size(); i++) {
			FisFuneralOrgan dataBean = arg0.get(i);
			dataBean.setCreateOrgan(fisOrganCode);
			dataBean.setCreateOrganName(fisOrganName);
			dataBean.setCreatePeople(empOrganId);
			dataBean.setCreatePeopleName(empOrganName);
			dataBean.setCreateTime(lastTimes);
		}
		super.batchUpdate(arg0);
	}

	@Override
	public void save(List<FisFuneralOrgan> arg0) {
		String fisOrganCode = FisIdHelp.getFisOrganCode(FisIdHelp.FIS_ORGAN_FH);
		String fisOrganName = FisIdHelp.getFisOrganName(FisIdHelp.FIS_ORGAN_FH);
		String empOrganId = BspUtil.getEmpOrgan().getOrganId();
		String empOrganName = BspUtil.getEmpOrgan().getOrganName();
		String lastTimes = DateUtil.getTime();

		for (int i = 0; i < arg0.size(); i++) {
			FisFuneralOrgan dataBean = arg0.get(i);
			dataBean.setCreateOrgan(fisOrganCode);
			dataBean.setCreateOrganName(fisOrganName);
			dataBean.setCreatePeople(empOrganId);
			dataBean.setCreatePeopleName(empOrganName);
			dataBean.setCreateTime(lastTimes);
		}
		super.save(arg0);
	}

	/**
	 * @Title: queryForExport
	 * @Description: TODO(数据导出时查询方法)
	 * @param pSet
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryForExport(ParameterSet pSet) {
		String qStartTime = (String) pSet.get("qStartTime");
		String qEndTime = (String) pSet.get("qEndTime");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(" SELECT * FROM FIS_FUNERAL_ORGAN O ");
		if (StringUtils.isNotEmpty(qStartTime)) {
			sqlBuffer.append(" where O.CREATE_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qStartTime);
		}
		if (StringUtils.isNotEmpty(qEndTime)) {
			sqlBuffer.append(" and O.CREATE_TIME <= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qEndTime);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sqlBuffer.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sqlBuffer.toString(), true);
		}
		return ds;
	}
}
