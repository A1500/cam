package com.inspur.cams.welfare.base.dao.support;


import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.welfare.base.dao.IWealElectronicfileContentDao;
import com.inspur.cams.welfare.base.data.WealElectronicfileContent;



/**
 * WealComfortNoDao
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 public class WealElectronicfileContentDao extends EntityDao<WealElectronicfileContent> implements IWealElectronicfileContentDao{

	@Override
	protected Class<WealElectronicfileContent> getEntityClass() {
		return WealElectronicfileContent.class;
	}
	
	/**
	 * 通过sql查询电子档案目录信息
	 */
	public DataSet queryElectronicfileCatalogBySql(ParameterSet pset){
		String companyType = (String) pset.getParameter("companyType");
		String applyId = (String) pset.getParameter("applyId");
		String applyType = (String) pset.getParameter("applyType");
		String companyName = (String) pset.getParameter("companyName");
		String catalogType = (String) pset.getParameter("catalogType");
		
		
		List<Integer> typeList = new ArrayList<Integer>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT CATALOG_ID,CATALOG_SN,CATALOG_NAME,CATALOG_NOTE,DOMICILE_CODE FROM WEAL_ELECTRONICFILE_CATALOG WHERE 1=1 ");
		sql.append(" AND IF_VALID='1' AND CATALOG_Type="+catalogType );
		sql.append("  ORDER BY CATALOG_ID ");
		
		DataSet catalogDS = new DataSet();
		catalogDS = this.executeDataset(sql.toString(), true);
		
		List<Record> list = catalogDS.getRecordSet();
		
		ArrayList<Record> records = new ArrayList<Record>();
		for (int i = 0; i < list.size(); i++) {
			Record map = (Record) list.get(i);
			WealElectronicfileContent bean = new WealElectronicfileContent();
			bean.setCatalogId((String) map.get("CATALOG_ID"));
			bean.setCatalogSn(new BigDecimal( map.get("CATALOG_SN").toString()));
			bean.setDomicileCode((String) map.get("DOMICILE_CODE"));
			
			bean.setCompanyName(companyName);
			bean.setApplyId(applyId);
			bean.setApplyType(applyType);
			bean.setCompanyType(companyType);
			getInfo(bean,null);
			Record record = new Record(bean);
			records.add(record);
		}
		DataSet electronicDS = new DataSet();
		electronicDS.getRecordSet().addAll(records);
		//electronicDS.setTotalCount(catalogDS.getTotalCount());
		return electronicDS;
	}
	/*通过sql查询上传内容
	 * */
	public void getInfo(WealElectronicfileContent electronicBean,String relatingCatalogCode) {
		String applyId = electronicBean.getApplyId();
		String applyType = electronicBean.getApplyType();
		String catalogId = electronicBean.getCatalogId();
		StringBuffer fileNameBuf = new StringBuffer();
		StringBuffer electronicIdBuf = new StringBuffer();
		StringBuffer fileMessBuf = new StringBuffer();
		String catalogCode = null;
		if(relatingCatalogCode!=null){
			catalogCode = relatingCatalogCode;
		}else{
			catalogCode = electronicBean.getCatalogId();
		}
		String str = new String();
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("SELECT * FROM WEAL_ELECTRONICFILE_CONTENT WHERE 1=1 ");
		if(applyId!=null && !("".equals(applyId))){
			sql.append(" AND APPLY_ID=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(applyId);
		}
		if(applyType!=null && !("".equals(applyType))){
			sql.append(" AND APPLY_TYPE=? ");
			typeList.add(Types.VARCHAR);
				objsList.add(applyType);
			
		}
		if(catalogId!=null && !("".equals(catalogId))){
			sql.append(" AND CATALOG_ID=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(catalogId);
		}
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			list = this.executeQuery(sql.toString(), types, args);
		}
		if(list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				fileNameBuf.append((String) list.get(i).get("CATALOG_NAME"));
				fileNameBuf.append(";");
				electronicIdBuf.append((String) list.get(i).get("CONTENT_ID"));
				electronicIdBuf.append(";");
				if (list.get(i).get("CATALOG_NOTE") == null) {
					fileMessBuf.append("无描述");
					fileMessBuf.append(";");
				} else {
					fileMessBuf.append((String) list.get(i).get("CATALOG_NOTE"));
					fileMessBuf.append(";");
				}
			}
			str = fileNameBuf.toString();
			if(electronicBean.getCatalogName()==null){
				electronicBean.setCatalogName(str.substring(0, str.length() - 1));
			}else{
				electronicBean.setCatalogName(str+electronicBean.getCatalogName());
			}
			str = electronicIdBuf.toString();
			if(electronicBean.getContentId()==null){
				electronicBean.setContentId(str.substring(0, str.length() - 1));
			}else{
				electronicBean.setContentId(str+electronicBean.getContentId());
			}
			str = fileMessBuf.toString();
			if(electronicBean.getCatalogNote()==null){
				electronicBean.setCatalogNote(str.substring(0, str.length() - 1));
			}else{
				electronicBean.setCatalogNote(str+electronicBean.getCatalogNote());
			}
			//将件号付给前台，对于同一目录的件号应该是一样的，所以取第一个文件的件号即可
			//electronicBean.setPieceNumber((String) list.get(0).get("PIECE_NUMBER"));
		}
	}
	
	/**
	 * 通过sql查询下载列表
	 */
	public DataSet queryCatalog(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		String ids = (String) pset.getParameter("ids");
		StringBuffer sql = new StringBuffer("");
		if (ids != null && !("".equals(ids.trim()))) {
			sql.append("SELECT * FROM WEAL_ELECTRONICFILE_CONTENT T WHERE 1=1 ");
			sql.append(" AND ( ");
			String[] ary = ids.split(";");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" CONTENT_ID=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if(i!=ary.length-1){
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		List<Record> list = ds.getRecordSet();
		DataSet returnDs = new DataSet();
		if(list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				Record rd = list.get(i);
				WealElectronicfileContent bean = new WealElectronicfileContent();
				bean.setContentId((String) rd.get("CONTENT_ID"));
				bean.setApplyId((String) rd.get("APPLY_ID"));
				bean.setApplyType((String) rd.get("APPLY_TYPE"));
				bean.setCatalogId((String) rd.get("CATALOG_ID") );
				bean.setCompanyType((String) rd.get("COMPANY_TYPE") );
				bean.setCompanyName((String) rd.get("COMPANY_NAME") );
				bean.setCatalogSn(new BigDecimal( rd.get("CATALOG_SN").toString()));
				bean.setCatalogName((String) rd.get("CATALOG_NAME") );
				bean.setCatalogNote((String) rd.get("CATALOG_NOTE") );
				bean.setDomicileCode((String) rd.get("DOMICILE_CODE") );
				
				returnDs.addRecord(bean);
			}
			returnDs.setTotalCount(ds.getTotalCount());
		}
		return returnDs;
	}
}
