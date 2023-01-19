abstract class BaseMapper<E, M> {
  E toEntity(M model);
  M toModel(E entity);
}
