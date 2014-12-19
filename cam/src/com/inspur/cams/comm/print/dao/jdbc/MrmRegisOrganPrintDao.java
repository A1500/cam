package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.print.dao.IPrintDao;
import com.inspur.cams.marry.base.dao.jdbc.MrmEnumDao;
import com.inspur.cams.marry.base.data.MrmRegisOrganInfo;

/**
 * 婚姻系统登记机关打印
 * 
 * @author Administrator
 * 
 */
public class MrmRegisOrganPrintDao extends IPrintDao {

	@Override
	protected Class getEntityClass() {
		// TODO Auto-generated method stub
		return MrmRegisOrganInfo.class;
	}
	/**
	@Override
	public DataSet queryData(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
				sql.append("select m.dept_code, ");
						sql.append(" m.name,");
						sql.append("  m.dept_address,");
						sql.append(" m.dept_post,");
						sql.append(" m.dept_tel,");
						sql.append(" m.dept_fax,");
						sql.append(" m.modify_id,");
						sql.append(" m.complain_tel,");
						sql.append(" m.office_email,");
						sql.append(" m.types,");
						sql.append(" m.sslevel,");
						sql.append(" m.last_year_budget,");
						sql.append(" m.this_year_budget,");
						sql.append(" m.creat_date,");
						sql.append(" m.dept_num_ry,");
						sql.append(" m.dept_num_rdbz,");
						sql.append(" m.dept_num_sj,");
						sql.append(" m.valid_flag,");
						sql.append(" c.full_name as regionName,");
						sql.append(" m.dept_organ,");
						sql.append(" m.jz_name,");
						sql.append(" m.jz_dh,");
						sql.append(" m.jz_sj,");
						sql.append(" m.zx_date,");
						sql.append(" m.lw_date,");
						sql.append(" m.wsyy_type,");
						sql.append(" m.begin_time, m.wlyul,  m.sjyyl,");
						sql.append(" m.skin_value,");
						sql.append(" m.abolish_date, m.abolish_ywgs,");
						sql.append(" m.abolish_reason,  m.home_url,");
						sql.append(" m.remark, m.people_dh");
						sql.append(" from MRM_REGIS_ORGAN_INFO m ,dic_city c ");
						sql.append(" where m.region_code=c.id  and m.organ_id=?");
						DataSet dataSet=	this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
								new Object[] { pset.getParameter("organId") }, true);
					
					if (dataSet.getCount() != 0) {
						for (int i = 0; i < dataSet.getCount(); i++) {
							if (dataSet.getRecord(i).get("TYPES") != null && !"".equals(dataSet.getRecord(i).get("TYPES"))) {
								String types = dataSet.getRecord(0).get("TYPES").toString();
								MrmEnumDao mrmEnumDao = new MrmEnumDao();
								String typesString = mrmEnumDao.toName(types,"MRM.FORMATION.NATURE");
								dataSet.getRecord(i).set("TYPES", typesString);
							}
							if (dataSet.getRecord(i).get("SSLEVEL") != null && !"".equals(dataSet.getRecord(i).get("SSLEVEL"))) {
								String types = dataSet.getRecord(0).get("SSLEVEL").toString();
								MrmEnumDao mrmEnumDao = new MrmEnumDao();
								String typesString = mrmEnumDao.toName(types,"MRM.FORMATION.NATURE");
								dataSet.getRecord(i).set("SSLEVEL", typesString);
							}
							if (dataSet.getRecord(i).get("VALID_FLAG") != null && !"".equals(dataSet.getRecord(i).get("VALID_FLAG"))) {
								String types = dataSet.getRecord(0).get("VALID_FLAG").toString();
								MrmEnumDao mrmEnumDao = new MrmEnumDao();
								String typesString = mrmEnumDao.toName(types,"MRM.FORMATION.NATURE");
								dataSet.getRecord(i).set("VALID_FLAG", typesString);
							}
							if (dataSet.getRecord(i).get("WS") != null && !"".equals(dataSet.getRecord(i).get("wsyy_type"))) {
								String types = dataSet.getRecord(0).get("TYPES").toString();
								MrmEnumDao mrmEnumDao = new MrmEnumDao();
								String typesString = mrmEnumDao.toName(types,"MRM.FORMATION.NATURE");
								dataSet.getRecord(i).set("TYPES", typesString);
							}
							if (dataSet.getRecord(i).get("TYPES") != null && !"".equals(dataSet.getRecord(i).get("TYPES"))) {
								String types = dataSet.getRecord(0).get("TYPES").toString();
								MrmEnumDao mrmEnumDao = new MrmEnumDao();
								String typesString = mrmEnumDao.toName(types,"MRM.FORMATION.NATURE");
								dataSet.getRecord(i).set("TYPES", typesString);
							}
						}
						
					}
					return dataSet;

	}
	**/
	
	
	@Override
	public DataSet queryData(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
				sql.append("select m.dept_code, ");
						sql.append(" m.name,");
						sql.append("  m.dept_address,");
						sql.append(" m.dept_post,");
						sql.append(" m.dept_tel,");
						sql.append(" m.dept_fax,");
						sql.append(" m.modify_id,");
						sql.append(" m.complain_tel,");
						sql.append(" m.office_email,");
						sql.append(" decode(m.types,");
						sql.append(" '01',");
						sql.append("  '行政单位',");
						sql.append(" '02',");
						sql.append(" '参公管理事业单位',");
						sql.append(" '03',");
						sql.append(" '全额拨款事业单位') as types,");
						sql.append(" decode(m.sslevel,");
						sql.append("   '01',,");;
						sql.append(" '处级',");
						sql.append(" '02',");
						sql.append(" '副处级',");
						sql.append(" '03',");
						sql.append("  '科级',");
						sql.append(" '04',");
						sql.append(" '副科级') as sslevel, ");
						sql.append(" m.last_year_budget,");
						sql.append(" m.this_year_budget,");
						sql.append("  m.creat_date,");
						sql.append("  m.dept_num_ry,");
						sql.append(" m.dept_num_rdbz,");
						sql.append("   m.dept_num_sj,");
						sql.append("  decode(m.valid_flag, '1', '正常', '0', '撤销', '9', '暂停') as valid_flag, ");
						sql.append(" c.full_name as regionName,");
						sql.append("  m.dept_organ,");
						sql.append(" m.jz_name,");
						sql.append(" m.jz_dh,");
						sql.append("  m.jz_sj,");
						sql.append(" m.zx_date,");
						sql.append(" m.lw_date,");
						sql.append(" decode(m.wsyy_type, '01', '自动生成', '02', '手工填写') as wsyy_type, ");
						sql.append(" m.begin_time, m.wlyul, m.sjyyl,");
						sql.append(" decode(m.skin_value, '01', '国家3A级',");
						sql.append(" '02','国家4A级','03','国家5A级',");
						sql.append(" '00', '无') as skin_value ,");
						sql.append("  m.abolish_date, m.abolish_ywgs,");
						sql.append(" m.abolish_reason, m.home_url,");
						sql.append("  m.remark, m.people_dh");
						sql.append(" from MRM_REGIS_ORGAN_INFO m ,dic_city c ");
						sql.append(" where m.region_code=c.id  and m.organ_id=?");

		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { pset.getParameter("organId") }, true);

	}
	
	/**
	@Override
	public DataSet queryData(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
				sql.append("select m.dept_code, ");
						sql.append(" m.name,");
						sql.append("  m.dept_address,");
						sql.append(" m.dept_post,");
						sql.append(" m.dept_tel,");
						sql.append(" m.dept_fax,");
						sql.append(" m.modify_id,");
						sql.append(" m.complain_tel,");
						sql.append(" m.office_email,");
						sql.append(" decode(m.types,");
						sql.append(" '01',");
						sql.append("  '行政单位',");
						sql.append(" '02',");
						sql.append(" '参公管理事业单位',");
						sql.append(" '03',");
						sql.append(" '全额拨款事业单位') as types,");
						sql.append(" decode(m.sslevel,");
						sql.append("   '01',,");;
						sql.append(" '处级',");
						sql.append(" '02',");
						sql.append(" '副处级',");
						sql.append(" '03',");
						sql.append("  '科级',");
						sql.append(" '04',");
						sql.append(" '副科级') as sslevel, ");
						sql.append(" m.last_year_budget,");
						sql.append(" m.this_year_budget,");
						sql.append("  m.creat_date,");
						sql.append("  m.dept_num_ry,");
						sql.append(" m.dept_num_rdbz,");
						sql.append("   m.dept_num_sj,");
						sql.append("  decode(m.valid_flag, '1', '正常', '0', '撤销', '9', '暂停') as valid_flag, ");
						sql.append(" c.full_name as regionName,");
						sql.append("  m.dept_organ,");
						sql.append(" m.jz_name,");
						sql.append(" m.jz_dh,");
						sql.append("  m.jz_sj,");
						sql.append(" m.zx_date,");
						sql.append(" m.lw_date,");
						sql.append(" decode(m.wsyy_type, '01', '自动生成', '02', '手工填写') as wsyy_type, ");
						sql.append(" m.begin_time," + "  m.wlyul," + "  m.sjyyl,");
						sql.append(" decode(m.skin_value," + " '01'," + " '国家3A级',");
						sql.append(" '02'," + " '国家4A级'," + " '03'," + " '国家5A级',");
						sql.append(" '00'," + " '无') as skin_value ,");
						sql.append("  m.abolish_date," + "   m.abolish_ywgs,");
						sql.append(" m.abolish_reason," + "  m.home_url,");
						sql.append("  m.remark," + " m.people_dh");
						sql.append(" from MRM_REGIS_ORGAN_INFO m ,dic_city c ");
						sql.append(" where m.region_code=c.id  and m.organ_id=?");

		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { pset.getParameter("organId") }, true);

	}
	**/
	

}
